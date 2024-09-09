/*
    Copyright 2020 Set Labs Inc.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

    SPDX-License-Identifier: Apache License, Version 2.0
*/

pragma solidity 0.6.10;
pragma experimental "ABIEncoderV2";

import {IPyth} from "@setToken/contracts/interfaces/external/IPyth.sol";
import {PythStructs} from "@setToken/contracts/interfaces/external/PythStructs.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {AddressArrayUtils} from "../lib/AddressArrayUtils.sol";
import {IController} from "../interfaces/IController.sol";
import {IOracle} from "../interfaces/IOracle.sol";
import {IOracleAdapter} from "../interfaces/IOracleAdapter.sol";
import {PreciseUnitMath} from "../lib/PreciseUnitMath.sol";

/**
 * @title PriceOracle
 * @author Set Protocol
 *
 * Contract that returns the price for any given asset pair. Price is retrieved either directly from an oracle,
 * calculated using common asset pairs, or uses external data to calculate price.
 * Note: Prices are returned in preciseUnits (i.e. 18 decimals of precision)
 */
contract PriceOracle is Ownable {
    using PreciseUnitMath for uint256;
    using AddressArrayUtils for address[];

    /* ============ Constants ============ */
    uint256 public constant PRICE_MULTIPLIER = 1e10;
    /* ============ Events ============ */

    event PairAdded(address indexed _assetOne, address indexed _assetTwo, bytes32 _oracle);
    event PairRemoved(address indexed _assetOne, address indexed _assetTwo, bytes32 _oracle);
    event PairEdited(address indexed _assetOne, address indexed _assetTwo, bytes32 _newOracleId);
    event AdapterAdded(address _adapter);
    event AdapterRemoved(address _adapter);
    event MasterQuoteAssetEdited(address _newMasterQuote);

    /* ============ State Variables ============ */

    // Address of the Controller contract
    IController public controller;
    // Address of the Pyth oracle contract
    IPyth public pyth;

    // Mapping between assetA/assetB and its associated Price Oracle
    // Asset 1 -> Asset 2 -> bytes32 (Oracle id)
    mapping(address => mapping(address => bytes32)) public oracles;

    // Token address of the bridge asset that prices are derived from if the specified pair price is missing
    address public masterQuoteAsset;

    // List of IOracleAdapters used to return prices of third party protocols (e.g. Uniswap, Compound, Balancer)
    address[] public adapters;

    /* ============ Constructor ============ */

    /**
     * Set state variables and map asset pairs to their oracles
     *
     * @param _controller             Address of controller contract
     * @param _pyth             Address of pyth contract
     * @param _masterQuoteAsset       Address of asset that can be used to link unrelated asset pairs
     * @param _adapters               List of adapters used to price assets created by other protocols
     * @param _assetOnes              List of first asset in pair, index i maps to same index in assetTwos and oracles
     * @param _assetTwos              List of second asset in pair, index i maps to same index in assetOnes and oracles
     * @param _oraclesId                List of orcales_id, index i maps to same index in assetOnes and assetTwos
     */
    constructor(
        IController _controller,
        IPyth _pyth,
        address _masterQuoteAsset,
        address[] memory _adapters,
        address[] memory _assetOnes,
        address[] memory _assetTwos,
        bytes32[] memory _oraclesId
    ) public {
        controller = _controller;
        pyth = _pyth;
        masterQuoteAsset = _masterQuoteAsset;
        adapters = _adapters;
        require(
            _assetOnes.length == _assetTwos.length && _assetTwos.length == _oraclesId.length,
            "Array lengths do not match."
        );

        for (uint256 i = 0; i < _assetOnes.length; i++) {
            oracles[_assetOnes[i]][_assetTwos[i]] = _oraclesId[i];
        }
    }

    /* ============ External Functions ============ */

    /**
     * SYSTEM-ONLY PRIVELEGE: Find price of passed asset pair, if possible. The steps it takes are:
     *  1) Check to see if a direct or inverse oracle of the pair exists,
     *  2) If not, use masterQuoteAsset to link pairs together (i.e. BTC/ETH and ETH/USDC
     *     could be used to calculate BTC/USDC).
     *  3) If not, check oracle adapters in case one or more of the assets needs external protocol data
     *     to price.
     *  4) If all steps fail, revert.
     *
     * @param _assetOne         Address of first asset in pair
     * @param _assetTwo         Address of second asset in pair
     * @return                  Price of asset pair to 18 decimals of precision
     */
    function getPrice(address _assetOne, address _assetTwo) external view returns (uint256) {
        // require(
        //     controller.isSystemContract(msg.sender),
        //     "PriceOracle.getPrice: Caller must be system contract."
        // );

        bool priceFound;
        uint256 price;
        (priceFound, price) = _getDirectOrInversePrice(_assetOne, _assetTwo);

        if (!priceFound) {
            (priceFound, price) = _getPriceFromMasterQuote(_assetOne, _assetTwo);
        }

        if (!priceFound) {
            (priceFound, price) = _getPriceFromAdapters(_assetOne, _assetTwo);
        }

        require(priceFound, "PriceOracle.getPrice: Price not found.");

        return price;
    }

    /**
     * GOVERNANCE FUNCTION: Add new asset pair oracle.
     *
     * @param _assetOne         Address of first asset in pair
     * @param _assetTwo         Address of second asset in pair
     * @param _oracleId         Oracle id of asset pair's oracle
     */
    function addPair(address _assetOne, address _assetTwo, bytes32 _oracleId) external onlyOwner {
        require(oracles[_assetOne][_assetTwo] == bytes32(0), "PriceOracle.addPair: Pair already exists.");
        oracles[_assetOne][_assetTwo] = _oracleId;

        emit PairAdded(_assetOne, _assetTwo, _oracleId);
    }

    /**
     * GOVERNANCE FUNCTION: Edit an existing asset pair's oracle.
     *
     * @param _assetOne         Address of first asset in pair
     * @param _assetTwo         Address of second asset in pair
     * @param _oracleId         Oracle Id of asset pair's new oracle
     */
    function editPair(address _assetOne, address _assetTwo, bytes32 _oracleId) external onlyOwner {
        require(oracles[_assetOne][_assetTwo] != bytes32(0), "PriceOracle.editPair: Pair doesn't exist.");
        oracles[_assetOne][_assetTwo] = _oracleId;

        emit PairEdited(_assetOne, _assetTwo, _oracleId);
    }

    /**
     * GOVERNANCE FUNCTION: Remove asset pair's oracle.
     *
     * @param _assetOne         Address of first asset in pair
     * @param _assetTwo         Address of second asset in pair
     */
    function removePair(address _assetOne, address _assetTwo) external onlyOwner {
        require(oracles[_assetOne][_assetTwo] != bytes32(0), "PriceOracle.removePair: Pair doesn't exist.");
        bytes32 oldOracle = oracles[_assetOne][_assetTwo];
        delete oracles[_assetOne][_assetTwo];

        emit PairRemoved(_assetOne, _assetTwo, oldOracle);
    }

    /**
     * GOVERNANCE FUNCTION: Add new oracle adapter.
     *
     * @param _adapter         Address of new adapter
     */
    function addAdapter(address _adapter) external onlyOwner {
        require(!adapters.contains(_adapter), "PriceOracle.addAdapter: Adapter already exists.");
        adapters.push(_adapter);

        emit AdapterAdded(_adapter);
    }

    /**
     * GOVERNANCE FUNCTION: Remove oracle adapter.
     *
     * @param _adapter         Address of adapter to remove
     */
    function removeAdapter(address _adapter) external onlyOwner {
        require(adapters.contains(_adapter), "PriceOracle.removeAdapter: Adapter does not exist.");
        adapters = adapters.remove(_adapter);

        emit AdapterRemoved(_adapter);
    }

    /**
     * GOVERNANCE FUNCTION: Change the master quote asset.
     *
     * @param _newMasterQuoteAsset         New address of master quote asset
     */
    function editMasterQuoteAsset(address _newMasterQuoteAsset) external onlyOwner {
        masterQuoteAsset = _newMasterQuoteAsset;

        emit MasterQuoteAssetEdited(_newMasterQuoteAsset);
    }

    /* ============ External View Functions ============ */

    /**
     * Returns an array of adapters
     */
    function getAdapters() external view returns (address[] memory) {
        return adapters;
    }

    /* ============ Internal Functions ============ */

    /**
     * Check if direct or inverse oracle exists. If so return that price along with boolean indicating
     * it exists. Otherwise return boolean indicating oracle doesn't exist.
     *
     * @param _assetOne         Address of first asset in pair
     * @param _assetTwo         Address of second asset in pair
     * @return bool             Boolean indicating if oracle exists
     * @return uint256          Price of asset pair to 18 decimal precision (if exists, otherwise 0)
     */
    function _getDirectOrInversePrice(address _assetOne, address _assetTwo) internal view returns (bool, uint256) {
        bytes32 oracleId = oracles[_assetOne][_assetTwo];
        bool hasDirectOracle = oracleId != bytes32(0);

        // Check asset1 -> asset 2. If exists, then return value
        if (hasDirectOracle) {
            return (true, readPrice(oracleId));
        }

        bytes32 inverseOracleId = oracles[_assetTwo][_assetOne];
        bool hasInverseOracle = inverseOracleId != bytes32(0);

        // If not, check asset 2 -> asset 1. If exists, then return 1 / asset1 -> asset2
        if (hasInverseOracle) {
            return (true, _calculateInversePrice(inverseOracleId));
        }

        return (false, 0);
    }

    /**
     * Try to calculate asset pair price by getting each asset in the pair's price relative to master
     * quote asset. Both prices must exist otherwise function returns false and no price.
     *
     * @param _assetOne         Address of first asset in pair
     * @param _assetTwo         Address of second asset in pair
     * @return bool             Boolean indicating if oracle exists
     * @return uint256          Price of asset pair to 18 decimal precision (if exists, otherwise 0)
     */
    function _getPriceFromMasterQuote(address _assetOne, address _assetTwo) internal view returns (bool, uint256) {
        (bool priceFoundOne, uint256 assetOnePrice) = _getDirectOrInversePrice(_assetOne, masterQuoteAsset);

        (bool priceFoundTwo, uint256 assetTwoPrice) = _getDirectOrInversePrice(_assetTwo, masterQuoteAsset);

        if (priceFoundOne && priceFoundTwo) {
            return (true, assetOnePrice.preciseDiv(assetTwoPrice));
        }

        return (false, 0);
    }

    /**
     * Scan adapters to see if one or more of the assets needs external protocol data to be priced. If
     * does not exist return false and no price.
     *
     * @param _assetOne         Address of first asset in pair
     * @param _assetTwo         Address of second asset in pair
     * @return bool             Boolean indicating if oracle exists
     * @return uint256          Price of asset pair to 18 decimal precision (if exists, otherwise 0)
     */
    function _getPriceFromAdapters(address _assetOne, address _assetTwo) internal view returns (bool, uint256) {
        for (uint256 i = 0; i < adapters.length; i++) {
            (bool priceFound, uint256 price) = IOracleAdapter(adapters[i]).getPrice(_assetOne, _assetTwo);

            if (priceFound) {
                return (priceFound, price);
            }
        }

        return (false, 0);
    }

    /**
     * Calculate inverse price of passed oracle. The inverse price is 1 (or 1e18) / inverse price
     *
     * @param _orcaleId        oracle id to invert
     * @return uint256              Inverted price of asset pair to 18 decimal precision
     */
    function _calculateInversePrice(bytes32 _orcaleId) internal view returns (uint256) {
        uint256 inverseValue = readPrice(_orcaleId);

        return PreciseUnitMath.preciseUnit().preciseDiv(inverseValue);
    }

    function readPrice(bytes32 _orcaleId) public view returns (uint256) {
        PythStructs.Price memory price = pyth.getPriceUnsafe(_orcaleId);
        uint256 assetPrice = uint256(price.price) * PRICE_MULTIPLIER;
        return assetPrice;
    }
}

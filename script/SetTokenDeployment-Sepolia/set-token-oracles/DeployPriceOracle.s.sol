// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;

import {Script, console} from "forge-std/Script.sol";
import {PriceOracle} from "@setToken/contracts/protocol/PriceOracle.sol";
import {ContractAddresses} from "./helper/ContractAddresses.sol";
import {IOracle} from "@setToken/contracts/interfaces/IOracle.sol";
import {IPyth} from "@setToken/contracts/interfaces/external/IPyth.sol";

contract DeployPriceOracle is Script, ContractAddresses {
    address masterQuoteAsset = usdc;
    address[] _adapters;
    address[] _assetOnes = [usdc, dai, weth, wbtc, link];
    address[] _assetTwos = [usdc, usdc, usdc, usdc, usdc];
    bytes32[] _oracles = [usdc_usd, dai_usd, eth_usd, btc_usd, link_usd];

    function run() external returns (PriceOracle) {
        uint256 deployerPrivateKey = vm.envUint("SET_TOKEN_MANAGER_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        PriceOracle priceOracle =
            new PriceOracle(controller, pythAddress, masterQuoteAsset, _adapters, _assetOnes, _assetTwos, _oracles);
        vm.stopBroadcast();
        console.log("Price oracle: %s", address(priceOracle));
        return priceOracle;
    }
}

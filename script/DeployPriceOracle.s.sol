// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;

import {Script} from "forge-std/Script.sol";
import {PriceOracle} from "../src/set-tokens-v2/protocol/PriceOracle.sol";
import {IController} from "../src/set-tokens-v2/interfaces/IController.sol";
import {IOracle} from "../src/set-tokens-v2/interfaces/IOracle.sol";

contract DeployController is Script {
    IController controller;
    address masterQuoteAsset;

    constructor(address _controller, address _masterQuoteAsset) public {
        controller = IController(_controller);
        masterQuoteAsset = _masterQuoteAsset;
    }

    function deployPriceOracle(
        address[] memory _adapters,
        address[] memory _assetOnes,
        address[] memory _assetTwos,
        IOracle[] memory _oracles
    ) public {
        vm.startBroadcast();
        PriceOracle priceOracle = new PriceOracle(
            controller,
            masterQuoteAsset,
            _adapters,
            _assetOnes,
            _assetTwos,
            _oracles
        );
        vm.stopBroadcast();
        return priceOracle;
    }

    function run() external returns (PriceOracle controller) {
        return deployPriceOracle();
    }
}

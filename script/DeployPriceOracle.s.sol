// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;

import {Script, console} from "forge-std/Script.sol";
import {PriceOracle} from "../src/set-tokens-v2/protocol/PriceOracle.sol";
import {IController} from "../src/set-tokens-v2/interfaces/IController.sol";
import {IOracle} from "../src/set-tokens-v2/interfaces/IOracle.sol";

contract DeployController is Script {
    IController controller;
    address masterQuoteAsset;
    address[] _adapters;
    address[] _assetOnes;
    address[] _assetTwos;
    IOracle[] _oracles;

    function run() external {
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
        console.log("Price oracle: %s", address(priceOracle));
    }
}

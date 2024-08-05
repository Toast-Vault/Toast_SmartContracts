// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;

import {Script, console} from "forge-std/Script.sol";
import {PriceOracle} from "@setToken/contracts/protocol/PriceOracle.sol";
import {ContractAddresses} from "./helper/ContractAddresses.sol";
import {IOracle} from "@setToken/contracts/interfaces/IOracle.sol";

contract DeployPriceOracle is Script, ContractAddresses {
    address masterQuoteAsset = usdc;
    address[] _adapters;
    address[] _assetOnes = [usdc, dai, wbtc, link];
    address[] _assetTwos = [usdc, usdc, usdc, usdc];
    IOracle[] _oracles = [usdc_usd, dai_usdc, wbtc_usd, link_usd];

    function run() external returns (PriceOracle) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
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
        return priceOracle;
    }
}

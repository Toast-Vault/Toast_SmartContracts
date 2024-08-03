// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;

import {Script, console} from "forge-std/Script.sol";
import {PriceOracle} from "../src/set-tokens-v2/protocol/PriceOracle.sol";
import {IController} from "../src/set-tokens-v2/interfaces/IController.sol";
import {IOracle} from "../src/set-tokens-v2/interfaces/IOracle.sol";

abstract contract Constants {
    address USDC = 0x473a827b9B50b2a8A711493C9F80CFeE96f3Be97;
    address DAI = 0x48feC5d47182698Ec10D1c258d90dC9dB142de41;
    address WBTC = 0x714F7a3d1A3F33fB09CE13f5033C0E576Cd0cE8e;
    address LINK = 0x5865665E51cA79A6462a88A14179056C73F681E1;

    IOracle USDC_USD = IOracle(0xE3e0c9a4f088C754c381d161d67A596721E613aB);
    IOracle DAI_USDC = IOracle(0x5934DE42541C7eF4860095d37344B71042c1706C);
    IOracle ETH_USD = IOracle(0x49ad1B642318202A5b20513B826918A328D8D6E4);
    IOracle WBTC_USD = IOracle(0x295349FBB6de65686382b20189632434894Ebe42);
    IOracle LINK_USD = IOracle(0x0a2658f1Fb8C8b734635A49dE6209c243c42b7F0);
}

contract DeployPriceOracle is Script, Constants {
    IController controller =
        IController(0x9Df9fef12Fa512315CC9F3e5C1D2faFf1bB04a72);
    address masterQuoteAsset = USDC;
    address[] _adapters;
    address[] _assetOnes = [USDC, DAI, WBTC, LINK];
    address[] _assetTwos = [USDC, USDC, USDC, USDC];
    IOracle[] _oracles = [USDC_USD, DAI_USDC, WBTC_USD, LINK_USD];

    function run() external returns (PriceOracle) {
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
        return priceOracle;
    }
}

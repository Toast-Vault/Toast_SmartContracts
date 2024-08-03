// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;

import {Script, console} from "forge-std/Script.sol";
import {WETH9} from "../src/set-tokens-v2/external/WETH9.sol";

contract DeployMockWETH is Script {
    function run() external returns (WETH9) {
        vm.startBroadcast();
        WETH9 wEth = new WETH9();
        vm.stopBroadcast();
        console.log("WETH token: %s : %s ", address(wEth));
        return wEth;
    }
}

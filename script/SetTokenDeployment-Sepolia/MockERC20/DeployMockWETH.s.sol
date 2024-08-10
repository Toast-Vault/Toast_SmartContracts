// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;

import {Script, console} from "forge-std/Script.sol";
import {WETH9} from "@setToken/contracts/external/WETH9.sol";

contract DeployMockWETH is Script {
    function run() external returns (WETH9) {
        uint256 deployerPrivateKey = vm.envUint(
            "SET_TOKEN_MANAGER_PRIVATE_KEY"
        );
        vm.startBroadcast(deployerPrivateKey);
        WETH9 wEth = new WETH9();
        vm.stopBroadcast();
        console.log("WETH token: %s : %s ", address(wEth));
        return wEth;
    }
}

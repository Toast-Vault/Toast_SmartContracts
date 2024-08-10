// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;

import {Script} from "forge-std/Script.sol";
import {SetTokenCreator} from "@setToken/contracts/protocol/SetTokenCreator.sol";
import {IController} from "@setToken/contracts/interfaces/IController.sol";

contract DeploySetTokenCreator is Script {
    IController controller =
        IController(0x9Df9fef12Fa512315CC9F3e5C1D2faFf1bB04a72);

    function run() external returns (SetTokenCreator) {
        uint256 deployerPrivateKey = vm.envUint(
            "SET_TOKEN_MANAGER_PRIVATE_KEY"
        );
        vm.startBroadcast(deployerPrivateKey);
        SetTokenCreator setTokenCreator = new SetTokenCreator(controller);
        vm.stopBroadcast();
        return setTokenCreator;
    }
}

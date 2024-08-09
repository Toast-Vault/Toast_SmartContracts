// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.10;

import {Script, console} from "forge-std/Script.sol";
import {IntegrationRegistry} from "@setToken/contracts/protocol/IntegrationRegistry.sol";
import {IController} from "@setToken/contracts/interfaces/IController.sol";

contract DeployIntegrationRegistry is Script {
    IController controller =
        IController(0x9Df9fef12Fa512315CC9F3e5C1D2faFf1bB04a72);

    function run() public returns (IntegrationRegistry) {
        uint256 deployerPrivateKey = vm.envUint(
            "SET_TOKEN_MANAGER_PRIVATE_KEY"
        );
        vm.startBroadcast(deployerPrivateKey);
        IntegrationRegistry integrationRegistry = new IntegrationRegistry(
            controller
        );
        vm.stopBroadcast();
        return integrationRegistry;
    }
}

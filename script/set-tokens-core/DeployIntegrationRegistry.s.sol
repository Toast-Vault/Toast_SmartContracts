// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.10;

import {Script, console} from "forge-std/Script.sol";
import {IntegrationRegistry} from "../../src/set-tokens-v2/protocol/IntegrationRegistry.sol";
import {IController} from "../../src/set-tokens-v2/interfaces/IController.sol";

contract DeployIntegrationRegistry is Script {
    IController controller =
        IController(0x9Df9fef12Fa512315CC9F3e5C1D2faFf1bB04a72);

    function run() public returns (IntegrationRegistry) {
        vm.startBroadcast();
        IntegrationRegistry integrationRegistry = new IntegrationRegistry(
            controller
        );
        vm.stopBroadcast();
        return integrationRegistry;
    }
}

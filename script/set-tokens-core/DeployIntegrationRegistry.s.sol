// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.6.10;

import {Script, console} from "forge-std/Script.sol";
import {IntegrationRegistry} from "../../src/set-tokens-v2/protocol/IntegrationRegistry.sol";
import {IController} from "../../src/set-tokens-v2/interfaces/IController.sol";

contract DeployIntegrationRegistry is Script {
    IController controller;

    constructor(address _controller) public {
        controller = IController(_controller);
    }

    function run() public returns (IntegrationRegistry) {
        vm.startBroadcast();
        IntegrationRegistry integrationRegistry = new IntegrationRegistry(
            controller
        );
        vm.stopBroadcast();
        return integrationRegistry;
    }
}

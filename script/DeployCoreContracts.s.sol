// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;

import {Script, console} from "forge-std/Script.sol";
import {DeployController} from "./set-tokens-core/DeployController.s.sol";
import {DeploySetTokenCreator} from "./set-tokens-core/DeploySetTokenCreator.s.sol";
import {DeploySetValuer} from "./set-tokens-core/DeploySetValuer.s.sol";
import {DeployIntegrationRegistry} from "./set-tokens-core/DeployIntegrationRegistry.s.sol";

contract DeployCoreContracts is Script {
    address _feeAddress = address(0);
    DeployController controller;
    DeploySetTokenCreator setTokenCreator;
    DeploySetValuer setValuer;
    DeployIntegrationRegistry integrationRegistry;

    function run() external {
        vm.startBroadcast();
        controller = new DeployController(_feeAddress);
        console.log("Contract deployer: ", address(controller));

        setTokenCreator = new DeploySetTokenCreator(address(controller));
        console.log("Set token: ", address(setTokenCreator));

        integrationRegistry = new DeployIntegrationRegistry(
            address(controller)
        );
        console.log("Integration Registry: ", address(integrationRegistry));

        setValuer = new DeploySetValuer(address(controller));
        console.log("Set valuer: ", address(setValuer));

        vm.stopBroadcast();
    }
}

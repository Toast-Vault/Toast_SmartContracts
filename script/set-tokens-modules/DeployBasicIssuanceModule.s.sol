// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;

import {Script, console} from "forge-std/Script.sol";
import {BasicIssuanceModule} from "../../src/set-tokens-v2/protocol/modules/v1/BasicIssuanceModule.sol";
import {IController} from "../../src/set-tokens-v2/interfaces/IController.sol";

contract DeployBasicIssuanceModule is Script {
    IController controller =
        IController(0x9Df9fef12Fa512315CC9F3e5C1D2faFf1bB04a72);

    function run() external returns (BasicIssuanceModule) {
        vm.startBroadcast();
        BasicIssuanceModule basicIssuanceModule = new BasicIssuanceModule(
            controller
        );
        vm.stopBroadcast();
        console.log("BasicIssuance Module: %s", address(basicIssuanceModule));
        return basicIssuanceModule;
    }
}

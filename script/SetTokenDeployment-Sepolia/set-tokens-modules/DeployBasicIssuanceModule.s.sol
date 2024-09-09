// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;

import {Script, console} from "forge-std/Script.sol";
import {BasicIssuanceModule} from "@setToken/contracts/protocol/modules/v1/BasicIssuanceModule.sol";
import {IController} from "@setToken/contracts/interfaces/IController.sol";

contract DeployBasicIssuanceModule is Script {
    IController controller = IController(0x9Df9fef12Fa512315CC9F3e5C1D2faFf1bB04a72);

    function run() external returns (BasicIssuanceModule) {
        uint256 deployerPrivateKey = vm.envUint("SET_TOKEN_MANAGER_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        BasicIssuanceModule basicIssuanceModule = new BasicIssuanceModule(controller);
        vm.stopBroadcast();
        console.log("BasicIssuance Module: %s", address(basicIssuanceModule));
        return basicIssuanceModule;
    }
}

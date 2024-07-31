// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;

import {Script} from "forge-std/Script.sol";
import {SetTokenCreator} from "../../src/set-tokens-v2/protocol/SetTokenCreator.sol";
import {IController} from "../../src/set-tokens-v2/interfaces/IController.sol";

contract DeploySetTokenCreator is Script {
    IController controller =
        IController(0x9Df9fef12Fa512315CC9F3e5C1D2faFf1bB04a72);

    function run() external returns (SetTokenCreator) {
        vm.startBroadcast();
        SetTokenCreator setTokenCreator = new SetTokenCreator(controller);
        vm.stopBroadcast();
        return setTokenCreator;
    }
}

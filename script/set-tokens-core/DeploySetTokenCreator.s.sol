// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;

import {Script} from "forge-std/Script.sol";
import {SetTokenCreator} from "../../src/set-tokens-v2/protocol/SetTokenCreator.sol";
import {IController} from "../../src/set-tokens-v2/interfaces/IController.sol";

contract DeploySetTokenCreator is Script {
    IController controller;

    constructor(address _controller) public {
        controller = IController(_controller);
    }

    function run() external returns (SetTokenCreator) {
        vm.startBroadcast();
        SetTokenCreator setTokenCreator = new SetTokenCreator(controller);
        vm.stopBroadcast();
        return setTokenCreator;
    }
}

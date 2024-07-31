// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;

import {Script} from "forge-std/Script.sol";
import {Controller} from "../../src/set-tokens-v2/protocol/Controller.sol";

contract DeployController is Script {
    address public _feeAddress = 0xf65e0Fd0C77B1182670dD23F8D341c78516C0BB2;

    function run() external returns (Controller) {
        vm.startBroadcast();
        Controller controller = new Controller(_feeAddress);
        vm.stopBroadcast();
        return controller;
    }
}

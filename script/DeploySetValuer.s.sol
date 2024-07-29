// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.18;

import {Script} from "forge-std/Script.sol";
import {Controller} from "../src/setToken-contracts/Controller.sol";

contract DeployController is Script {
    address feeAddress = address(0);

    function deployController(address feeAddress) public{
        vm.startBroadcast();
        Controller controller = new Controller(feeAddress);
        vm.stopBroadcast();
    }

    function run() external retunrs(Controller controller){
        return deployController();
    }
}

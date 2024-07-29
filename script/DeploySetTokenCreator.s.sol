// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.18;

import {Script} from "forge-std/Script.sol";
import {SetTokenCreator} from "../src/setToken-contracts/SetTokenCreator.sol";

contract DeploySetTokenCreator is Script {
    address feeAddress = address(0);

    function deploySetTokenCreator(address controller) public{
        vm.startBroadcast();
        SetTokenCreator setTokenCreator = new SetTokenCreator(controller);
        vm.stopBroadcast();
    }

    function run() external retunrs(SetTokenCreator setTokenCreator){
        return deploySetTokenCreator();
    }
}

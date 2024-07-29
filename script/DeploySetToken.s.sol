// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.18;

import {Script} from "forge-std/Script.sol";
import {SetToken} from "../src/setToken-contracts/SetToken.sol";

contract DeploySetToken is Script {
    address feeAddress;
    function deploySetToken() public{
        vm.startBroadcast();
        SetToken setToken = new SetToken(feeAddress);
        vm.stopBroadcast();
    }

    function run(address _feeAddress) external retunrs(SetToken setToken){
        feeAddress = _feeAddress;
        return deploySetToken();
    }
}

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;

import {Script, console} from "forge-std/Script.sol";
import {SetToken} from "@setToken/contracts/protocol/SetToken.sol";
import {ContractAddresses} from "./helper/ContractAddresses.s.sol";
import {Controller} from "@setToken/contracts/protocol/Controller.sol";
import {ISetValuer} from "@setToken/contracts/interfaces/ISetValuer.sol";

contract TokenSetConfig is Script, ContractAddresses {
    address public controllerManager = 0x00fBd18efDE748E1B3f7Bb01C79FbC318610b807;
    address public tokenSetManager = 0xfeB42b6c3c4250F435c20cFF22eA2FE386A830F2;

    function run() external {
        uint256 tokenSetManagerPrivateKey = vm.envUint("MANAGER_PRIVATE_KEY");
        uint256 controllerManagerPrivateKey = vm.envUint("SET_TOKEN_MANAGER_PRIVATE_KEY");

        setManagerController(controllerManager, controllerManagerPrivateKey);
        setManagerTokenSet(tokenSetManager, tokenSetManagerPrivateKey);
        getControllerManager();
        getTokenSetManager();
        setModuleStatePending(customOracleNavIssuanceModuleAddress, tokenSetManagerPrivateKey);
        isModulePending(address(usdcBtcLink), customOracleNavIssuanceModuleAddress);
        getModules(address(usdcBtcLink));
    }

    function setManagerController(address newManager, uint256 privateKey) public {
        Controller controller = Controller(address(controllerAddress));
        vm.startBroadcast(privateKey);
        controller.transferOwnership(newManager);
        console.log("Change Controller manager to %s", newManager);
        vm.stopBroadcast();
    }

    function setManagerTokenSet(address newManager, uint256 privateKey) public {
        SetToken setToken = SetToken(payable(address(usdcBtcLink)));
        vm.startBroadcast(privateKey);
        setToken.setManager(newManager);
        console.log("New set token manager is %s", newManager);
        vm.stopBroadcast();
    }

    function getControllerManager() public view {
        Controller controller = Controller(address(controllerAddress));
        address owner = controller.owner();
        console.log("Controller Mmanager: %s", owner);
    }

    function setModuleStatePending(address module, uint256 privateKey) public {
        SetToken setToken = SetToken(payable(address(usdcBtcLink)));
        vm.startBroadcast(privateKey);
        setToken.addModule(module);
        console.log("%s module has been init to pending state", module);
        vm.stopBroadcast();
    }

    function getTokenSetManager() public view {
        SetToken setToken = SetToken(payable(address(usdcBtcLink)));
        address owner = setToken.manager();
        console.log("Set token manager: %s", owner);
    }

    function isModulePending(address setTokenAdd, address module) public view returns (bool) {
        SetToken setToken = SetToken(payable(setTokenAdd));
        bool isPending = setToken.isPendingModule(module);
        console.log("Is %s module pending? %s", module, isPending);
    }

    function getModules(address setTokenAdd) public view {
        SetToken setToken = SetToken(payable(setTokenAdd));
        address[] memory modules = setToken.getModules();
        for (uint256 i = 0; i < modules.length; i++) {
            console.log(modules[i]);
        }
    }
}

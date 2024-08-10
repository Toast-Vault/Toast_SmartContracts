// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;
//we need to use diff script with 0.6.20 versio to interact with setToken
import {Script, console} from "forge-std/Script.sol";
import {SetToken} from "@setToken/contracts/protocol/SetToken.sol";
import {ContractAddresses} from "./helper/ContractAddresses.s.sol";
import {Controller} from "@setToken/contracts/protocol/Controller.sol";
import {CustomOracleNavIssuanceModule} from "@setToken/contracts/protocol/modules/v1/CustomOracleNAVIssuanceModule.sol";
import {INAVIssuanceHook} from "@setToken/contracts/interfaces/INAVIssuanceHook.sol";
import {ISetValuer} from "@setToken/contracts/interfaces/ISetValuer.sol";

contract TokenSetConfig is Script, ContractAddresses {
    address public controllerManager =
        0x00fBd18efDE748E1B3f7Bb01C79FbC318610b807;
    address public tokenSetManager = 0xfeB42b6c3c4250F435c20cFF22eA2FE386A830F2;

    function run() external {
        uint256 tokenSetManagerPrivateKey = vm.envUint("MANAGER_PRIVATE_KEY");
        uint256 controllerManagerPrivateKey = vm.envUint(
            "SET_TOKEN_MANAGER_PRIVATE_KEY"
        );

        setManagerController(controllerManager, controllerManagerPrivateKey);
        setManagerTokenSet(tokenSetManager, tokenSetManagerPrivateKey);
        getControllerManager();
        getTokenSetManager();
    }

    function setManagerController(
        address newManager,
        uint256 privateKey
    ) public {
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

    function getTokenSetManager() public view {
        SetToken setToken = SetToken(payable(address(usdcBtcLink)));
        address owner = setToken.manager();
        console.log("Set token manager: %s", owner);
    }
}

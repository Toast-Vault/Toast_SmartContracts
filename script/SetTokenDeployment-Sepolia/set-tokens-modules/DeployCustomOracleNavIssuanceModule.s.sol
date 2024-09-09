// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;

import {Script, console} from "forge-std/Script.sol";
import {IController} from "@setToken/contracts/interfaces/IController.sol";
import {CustomOracleNavIssuanceModule} from "@setToken/contracts/protocol/modules/v1/CustomOracleNAVIssuanceModule.sol";
import {IWETH} from "@setToken/contracts/interfaces/external/IWETH.sol";

contract DeployCustomOracleNavIssuanceModule is Script {
    IController controller = IController(0x9Df9fef12Fa512315CC9F3e5C1D2faFf1bB04a72);
    IWETH wEth = IWETH(0x295349FBB6de65686382b20189632434894Ebe42);

    function run() external returns (CustomOracleNavIssuanceModule) {
        uint256 deployerPrivateKey = vm.envUint("SET_TOKEN_MANAGER_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        CustomOracleNavIssuanceModule customOracleNavIssuanceModule =
            new CustomOracleNavIssuanceModule(controller, wEth);
        vm.stopBroadcast();
        console.log("CustomOracleNavIssuance Module: %s", address(customOracleNavIssuanceModule));
        return customOracleNavIssuanceModule;
    }
}

// TO DO:
// 1. Init the module contract.
// 2. Add USDC as a supported reserve token,
// 3. Change the owner and manager of setFactory and setToken respectively.

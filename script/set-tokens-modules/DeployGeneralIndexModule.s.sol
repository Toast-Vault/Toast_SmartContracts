// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;

import {Script, console} from "forge-std/Script.sol";
import {GeneralIndexModule} from "../../src/set-tokens-v2/protocol/modules/v1/GeneralIndexModule.sol";
import {IController} from "../../src/set-tokens-v2/interfaces/IController.sol";
import {IWETH} from "../../src/set-tokens-v2/interfaces/external/IWETH.sol";

contract DeployGeneralIndexModule is Script {
    IController controller =
        IController(0x9Df9fef12Fa512315CC9F3e5C1D2faFf1bB04a72);
    IWETH wEth = IWETH(0x295349FBB6de65686382b20189632434894Ebe42);

    function run() external returns (GeneralIndexModule) {
        vm.startBroadcast();
        GeneralIndexModule generalIndexModule = new GeneralIndexModule(
            controller,
            wEth
        );
        vm.stopBroadcast();
        console.log("General index Module: %s", address(generalIndexModule));
        return generalIndexModule;
    }
}

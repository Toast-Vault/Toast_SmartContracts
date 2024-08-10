// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;

import {Script, console} from "forge-std/Script.sol";
import {ContractAddresses} from "./helper/ContractAddresses.sol";
import {SetTokenCreator} from "@setToken/contracts/protocol/SetTokenCreator.sol";
import {BasicIssuanceModule} from "@setToken/contracts/protocol/modules/v1/BasicIssuanceModule.sol";
import {GeneralIndexModule} from "@setToken/contracts/protocol/modules/v1/GeneralIndexModule.sol";
import {ISetToken} from "@setToken/contracts/interfaces/ISetToken.sol";
import {IManagerIssuanceHook} from "@setToken/contracts/interfaces/IManagerIssuanceHook.sol";
import {IController} from "@setToken/contracts/interfaces/IController.sol";

// Utilise this script to make new tokenSet
// Set tokens already deployed with below components and manager.
// Edit components and units to deploy with different ratio.

contract DeploySetToken is Script, ContractAddresses {
    address manager = 0xc188653c4755C71b09d0CBB2CBD24d7b915F8083;
    string name = "USDC_BTC_LINK";
    string symbol = "UBL";
    address[] components = [mockUSDC, mockWBTC, mockLINK];
    address[] modules = [
        address(basicIssuanceModuleAddress),
        address(generalIndexModuleAddress)
    ];
    int256[] units = [
        50e18 /*50 USDC*/,
        1e16 /*0.001 WBTC*/,
        25e18 /*25 LINK*/
    ];

    function run() external {
        // Private has to be of the manager address mentioned above. Edit it accordingly.
        uint256 deployerPrivateKey = vm.envUint("MANAGER_PRIVATE_KEY");
        // Deploy token
        address setTokenAddress = deploySetToken(deployerPrivateKey);
        ISetToken setToken = ISetToken(setTokenAddress);
        // Initialize the module for new `setTokenAddress`
        // This module is needed to mint and redeem setTokens. Once added, this module can not be removed.
        initBasicIssuanceModule(deployerPrivateKey, setToken);
        // This module is needed to rebalance the vault. Rebalance can only be called by Manager and selected trader.
        initGeneralIndexModule(deployerPrivateKey, setToken);
    }

    function deploySetToken(uint256 privateKey) public returns (address) {
        SetTokenCreator controller = SetTokenCreator(
            address(setTokenCreatorAddress)
        );
        address setTokenAddress;

        vm.startBroadcast(privateKey);
        setTokenAddress = controller.create(
            components,
            units,
            modules,
            manager,
            name,
            symbol
        );
        console.log("Set created: %s", setTokenAddress);
        //console.log(sets);
        vm.stopBroadcast();
        return setTokenAddress;
    }

    function initBasicIssuanceModule(
        uint256 privateKey,
        ISetToken setToken
    ) public {
        BasicIssuanceModule basicIssuanceModule = BasicIssuanceModule(
            address(basicIssuanceModuleAddress)
        );
        vm.startBroadcast(privateKey);
        basicIssuanceModule.initialize(setToken, managerIssuanceHookAddress);
        console.log("Basic issuance module has been initialized");
        vm.stopBroadcast();
    }

    function initGeneralIndexModule(
        uint256 privateKey,
        ISetToken setToken
    ) public {
        GeneralIndexModule generalIndexModule = GeneralIndexModule(
            generalIndexModuleAddress
        );
        vm.startBroadcast(privateKey);
        generalIndexModule.initialize(setToken);
        console.log("General Index module has been initialized");
        vm.stopBroadcast();
    }
}

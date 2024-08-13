// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;
pragma experimental "ABIEncoderV2";

import {Script, console} from "forge-std/Script.sol";
import {ContractAddresses} from "./helper/ContractAddresses.sol";
import {SetTokenCreator} from "@setToken/contracts/protocol/SetTokenCreator.sol";
import {BasicIssuanceModule} from "@setToken/contracts/protocol/modules/v1/BasicIssuanceModule.sol";
import {GeneralIndexModule} from "@setToken/contracts/protocol/modules/v1/GeneralIndexModule.sol";
import {ISetToken} from "@setToken/contracts/interfaces/ISetToken.sol";
import {IController} from "@setToken/contracts/interfaces/IController.sol";

// Utilise this script to make new tokenSet
// Set tokens already deployed with below components and manager.
// Edit components and units to deploy with different ratio.

contract DeploySetToken is Script, ContractAddresses {
    string name = "BTC_USDC_LINK";
    string symbol = "BUL";
    address[] components = [mockUSDC, mockWBTC, mockLINK];
    address[] modules = [
        address(basicIssuanceModuleAddress),
        address(generalIndexModuleAddress),
        customOracleNavIssuanceModuleAddress
    ];
    int256[] units = [50e6 /*50 USDC*/, 1e15 /*0.001 WBTC*/, 15e18 /*15 LINK*/];

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
        address manager = vm.addr(privateKey);
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
// This is for customOracleNavIssuanceModule initialization to pending state. This is mandoratory before calling init() from module contract. This module is using struct which is not supported by older version of solidity. We can either call the function by etherscan or cast.
// cast send 0x392F1587db195283E247CeECe541c6a744C3E7D7 "initialize(address,(address,address,address,address[],address,uint256[2],uint256,uint256,uint256,uint256))" \
// 0xd995E679A577C29Ad7E06d1e3d194c961930E590 \
// "(0x0000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000,0x0000000000000000000000000000000000000000,[0x473a827b9B50b2a8A711493C9F80CFeE96f3Be97], 0xfeB42b6c3c4250F435c20cFF22eA2FE386A830F2,[0,0],900000000000000000,0,900000000000000000,1)"

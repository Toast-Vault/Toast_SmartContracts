// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;

import {IController} from "@setToken/contracts/interfaces/IController.sol";
import {ISetToken} from "@setToken/contracts/interfaces/ISetToken.sol";
import {ISetTokenCreator} from "@setToken/contracts/interfaces/ISetTokenCreator.sol";
import {IManagerIssuanceHook} from "@setToken/contracts/interfaces/IManagerIssuanceHook.sol";
import {IBasicIssuanceModule} from "@setToken/contracts/interfaces/IBasicIssuanceModule.sol";
import {IPriceOracle} from "@setToken/contracts/interfaces/IPriceOracle.sol";
import {IWETH} from "@setToken/contracts/interfaces/external/IWETH.sol";
import {IIntegrationRegistry} from "@setToken/contracts/interfaces/IIntegrationRegistry.sol";
import {ISetValuer} from "@setToken/contracts/interfaces/ISetValuer.sol";

abstract contract ContractAddresses {
    // SetToken address
    ISetToken usdcBtcLink = ISetToken(0xd995E679A577C29Ad7E06d1e3d194c961930E590);

    IWETH wEth = IWETH(0x295349FBB6de65686382b20189632434894Ebe42);
    address mockDAI = 0x48feC5d47182698Ec10D1c258d90dC9dB142de41;
    address mockUSDC = 0x473a827b9B50b2a8A711493C9F80CFeE96f3Be97;
    address mockWBTC = 0x714F7a3d1A3F33fB09CE13f5033C0E576Cd0cE8e;
    address mockLINK = 0x5865665E51cA79A6462a88A14179056C73F681E1;

    IManagerIssuanceHook managerIssuanceHookAddress = IManagerIssuanceHook(address(0));
    IController controllerAddress = IController(0x9Df9fef12Fa512315CC9F3e5C1D2faFf1bB04a72);
    IIntegrationRegistry integrationRegistryAddress = IIntegrationRegistry(0x2Fb11ea7CEE5e62E4709BB7BE420C4EaBfA3ea0A);
    ISetTokenCreator setTokenCreatorAddress = ISetTokenCreator(0x7c4Bb129E929A955e36137144607Fb32be52b804);
    ISetValuer setValuerAddress = ISetValuer(0x012d6bC94051C3b9F923c043A51D381903EAC16A);
    IPriceOracle priceOracleAddress = IPriceOracle(0x49ad1B642318202A5b20513B826918A328D8D6E4);
    IBasicIssuanceModule basicIssuanceModuleAddress = IBasicIssuanceModule(0x38Ea574B6dC8229575b195CF77CeCC3C1749E5e5);
    address generalIndexModuleAddress = 0x6D06248e18d2A713912CeDE4203213ce15307Ca0;
    address customOracleNavIssuanceModuleAddress = (0x392F1587db195283E247CeECe541c6a744C3E7D7);
}

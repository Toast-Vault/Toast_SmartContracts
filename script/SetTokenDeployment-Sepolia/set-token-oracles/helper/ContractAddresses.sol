// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;

import {IOracle} from "@setToken/contracts/interfaces/IOracle.sol";
import {IController} from "@setToken/contracts/interfaces/IController.sol";

abstract contract ContractAddresses {
    address usdc = 0x473a827b9B50b2a8A711493C9F80CFeE96f3Be97;
    address dai = 0x48feC5d47182698Ec10D1c258d90dC9dB142de41;
    address wbtc = 0x714F7a3d1A3F33fB09CE13f5033C0E576Cd0cE8e;
    address link = 0x5865665E51cA79A6462a88A14179056C73F681E1;

    IController controller =
        IController(0x9Df9fef12Fa512315CC9F3e5C1D2faFf1bB04a72);

    IOracle usdc_usd = IOracle(0xd9DC501B9E4437683ABfe83B377748Af7265b562);
    IOracle dai_usdc = IOracle(0xdc51ab0258B5ff93E2CEea0cf6aAD6937E346FE0);
    IOracle eth_usd = IOracle(0xeD7A35c4Ee06ea4e3203471d1b022019849F8EDA);
    IOracle wbtc_usd = IOracle(0x5920257792dBba08dfadD34607B781E3C2CDb3cF);
    IOracle link_usd = IOracle(0x6aE07395E64A0bEd5529e170C1A0b667E05D4Ad3);
}

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;

import {IOracle} from "@setToken/contracts/interfaces/IOracle.sol";
import {IController} from "@setToken/contracts/interfaces/IController.sol";
import {IPyth} from "@setToken/contracts/interfaces/external/IPyth.sol";

abstract contract ContractAddresses {
    address usdc = 0x473a827b9B50b2a8A711493C9F80CFeE96f3Be97;
    address dai = 0x48feC5d47182698Ec10D1c258d90dC9dB142de41;
    address wbtc = 0x714F7a3d1A3F33fB09CE13f5033C0E576Cd0cE8e;
    address link = 0x779877A7B0D9E8603169DdbD7836e478b4624789; // Token deployed by chainlink on Sepolia

    IController controller =
        IController(0x9Df9fef12Fa512315CC9F3e5C1D2faFf1bB04a72);
    IPyth pyth = IPyth(0xDd24F84d36BF92C65F92307595335bdFab5Bbd21);

    // IOracle usdc_usd = IOracle(0xd9DC501B9E4437683ABfe83B377748Af7265b562);
    // IOracle dai_usdc = IOracle(0xdc51ab0258B5ff93E2CEea0cf6aAD6937E346FE0);
    // IOracle eth_usd = IOracle(0xeD7A35c4Ee06ea4e3203471d1b022019849F8EDA);
    // IOracle wbtc_usd = IOracle(0x5920257792dBba08dfadD34607B781E3C2CDb3cF);
    // IOracle link_usd = IOracle(0x6aE07395E64A0bEd5529e170C1A0b667E05D4Ad3);

    // Pyth network assets id
    bytes32 dai_usd =
        0xb0948a5e5313200c632b51bb5ca32f6de0d36e9950a942d19751e833f70dabfd;
    bytes32 usdc_usd =
        0xeaa020c61cc479712813461ce153894a96a6c00b21ed0cfc2798d1f9a9e9c94a;
    bytes32 btc_usd =
        0xe62df6c8b4a85fe1a67db44dc12de5db330f7ac66b72dc658afedf0f4a415b43;
    bytes32 eth_usd =
        0xff61491a931112ddf1bd8147cd1b641375f79f5825126d665480874634fd0ace;
    bytes32 pendle_usd =
        0x9a4df90b25497f66b1afb012467e316e801ca3d839456db028892fe8c70c8016;
    bytes32 link_usd =
        0x9a4df90b25497f66b1afb012467e316e801ca3d839456db028892fe8c70c8016;
    bytes32 uni_usd =
        0x78d185a741d07edb3412b09008b7c5cfb9bbbd7d568bf00ba737b456ba171501;
    bytes32 aave_usd =
        0x2b9ab1e972a281585084148ba1389800799bd4be63b957507db1349314e47445;
    bytes32 mkr_usd =
        0x9375299e31c0deb9c6bc378e6329aab44cb48ec655552a70d4b9050346a30378;
    bytes32 grt_usd =
        0x4d1f8dae0d96236fb98e8f47471a366ec3b1732b47041781934ca3a9bb2f35e7;
    bytes32 ldo_usd =
        0xc63e2a7f37a04e5e614c07238bedb25dcc38927fba8fe890597a593c0b2fa4ad;
    bytes32 sand_usd =
        0xcb7a1d45139117f8d3da0a4b67264579aa905e3b124efede272634f094e1e9d1;
    bytes32 gala_usd =
        0x0781209c28fda797616212b7f94d77af3a01f3e94a5d421760aef020cf2bcb51;
    bytes32 beam_usd =
        0x3871d0ef1cf9e26005e4bbf7822f67a8883071a9d8a4e7a0125d2484cca7671f;
    bytes32 mana_usd =
        0x1dfffdcbc958d732750f53ff7f06d24bb01364b3f62abea511a390c74b8d16a5;
    bytes32 snx_usd =
        0x39d020f60982ed892abbcd4a06a276a9f9b7bfbce003204c110b6e488f502da3;
    bytes32 blur_usd =
        0x856aac602516addee497edf6f50d39e8c95ae5fb0da1ed434a8c2ab9c3e877e9;
    bytes32 wld_usd =
        0xd6835ad1f773de4a378115eb6824bd0c0e42d84d1c84d9750e853fb6b6c7794a;
    bytes32 akt_usd =
        0x0affd4b8ad136a21d79bc82450a325ee12ff55a235abc242666e423b8bcffd03;
    bytes32 near_usd =
        0xc415de8d2eba7db216527dff4b60e8f3a5311c740dadb233e13e12547e226750;
    bytes32 celo_usd =
        0xc415de8d2eba7db216527dff4b60e8f3a5311c740dadb233e13e12547e226750;
    bytes32 xtz_usd =
        0x0affd4b8ad136a21d79bc82450a325ee12ff55a235abc242666e423b8bcffd03;
    bytes32 flow_usd =
        0x2fb245b9a84554a0f15aa123cbb5f64cd263b59e9a87d80148cbffab50c69f30;
    bytes32 matic_usd =
        0x5de33a9112c2b700b8d30b8a3402c103578ccfa2765696471cc672bd5cf6ac52;
}

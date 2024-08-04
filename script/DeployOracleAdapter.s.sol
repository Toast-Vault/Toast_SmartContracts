// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;
import {Script, console} from "forge-std/Script.sol";
import {ChainlinkOracleAdapter} from "../src/set-tokens-v2/adapter/ChainlinkOracleAdapter.sol";

import {AggregatorInterface} from "../src/set-tokens-v2/interfaces/external/IAggregatorInterface.sol";

contract DeployOracleAdapter is Script {
    // Below oracle addresses is of Sepolia testnet chainlink oracles
    AggregatorInterface USDC_USD =
        AggregatorInterface(0xA2F78ab2355fe2f984D808B5CeE7FD0A93D5270E);
    AggregatorInterface DAI_USDC =
        AggregatorInterface(0x14866185B1962B63C3Ea9E03Bc1da838bab34C19);
    AggregatorInterface ETH_USD =
        AggregatorInterface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    AggregatorInterface BTC_USD =
        AggregatorInterface(0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43);
    AggregatorInterface LINK_USD =
        AggregatorInterface(0xc59E3633BAAC79493d908e63626716e204A45EdF);

    function run() external {
        vm.startBroadcast();
        ChainlinkOracleAdapter chainlinkUSDCAdapter = new ChainlinkOracleAdapter(
                USDC_USD
            );
        console.log("USDC-USD adpter %s", address(chainlinkUSDCAdapter));

        ChainlinkOracleAdapter chainlinkDAIAdapter = new ChainlinkOracleAdapter(
            DAI_USDC
        );
        console.log("DAI-USDC adpter %s", address(chainlinkDAIAdapter));

        ChainlinkOracleAdapter chainlinkETHAdapter = new ChainlinkOracleAdapter(
            ETH_USD
        );
        console.log("ETH-USD adpter %s", address(chainlinkETHAdapter));

        ChainlinkOracleAdapter chainlinkBTCAdapter = new ChainlinkOracleAdapter(
            BTC_USD
        );
        console.log("BTC-USD adpter %s", address(chainlinkBTCAdapter));

        ChainlinkOracleAdapter chainlinkLINKAdapter = new ChainlinkOracleAdapter(
                LINK_USD
            );
        console.log("LINK-USD adpter %s", address(chainlinkLINKAdapter));
    }
}

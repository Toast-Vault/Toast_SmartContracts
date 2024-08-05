// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;

import {AggregatorInterface} from "@setToken/contracts/interfaces/external/IAggregatorInterface.sol";

abstract contract ContractAddresses {
    // Below oracle addresses is of Sepolia testnet chainlink oracles
    AggregatorInterface usdc_usd =
        AggregatorInterface(0xA2F78ab2355fe2f984D808B5CeE7FD0A93D5270E);
    AggregatorInterface dai_usdc =
        AggregatorInterface(0x14866185B1962B63C3Ea9E03Bc1da838bab34C19);
    AggregatorInterface eth_usd =
        AggregatorInterface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    AggregatorInterface btc_usd =
        AggregatorInterface(0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43);
    AggregatorInterface link_usd =
        AggregatorInterface(0xc59E3633BAAC79493d908e63626716e204A45EdF);
}

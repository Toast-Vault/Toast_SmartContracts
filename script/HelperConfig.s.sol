// SPDX-License-Identifier: MIT
pragma solidity 0.6.10;
pragma experimental ABIEncoderV2;

import {Script, console} from "forge-std/Script.sol";

abstract contract CodeConstants {
    uint256 public constant ETH_SEPOLIA_CHAIN_ID = 11155111;
    uint256 public constant ETH_MAINNET_CHAIN_ID = 1;
    uint256 public constant LOCAL_CHAIN_ID = 31337;
}

contract HelperConfig is CodeConstants, Script {
    struct NetworkConfig {
        address feeAddress;
        address chainLink_USDC_USD;
        address chainLink_DAI_USDC;
        address chainLink_ETH_USD;
        address chainLink_BTC_USD;
        address chainLink_LINK_USD;
    }

    // Local network state variables
    NetworkConfig public localNetworkConfig;
    mapping(uint256 => NetworkConfig) public networkConfigs;

    constructor() public {
        networkConfigs[ETH_SEPOLIA_CHAIN_ID] = getSepoliaEthConfig();
        networkConfigs[ETH_MAINNET_CHAIN_ID] = getMainnetEthConfig();
    }

    function getConfig() public pure returns (NetworkConfig memory) {
        uint256 id;
        assembly {
            id := chainid()
        }
        return getConfigByChainId(id);
    }

    function getConfigByChainId(
        uint256 chainId
    ) public pure returns (NetworkConfig memory) {
        if (chainId == ETH_SEPOLIA_CHAIN_ID) {
            return getSepoliaEthConfig();
        } else {
            return getMainnetEthConfig();
        }
    }

    function getMainnetEthConfig()
        public
        pure
        returns (NetworkConfig memory mainnetNetworkConfig)
    {
        mainnetNetworkConfig = NetworkConfig({
            feeAddress: 0xf65e0Fd0C77B1182670dD23F8D341c78516C0BB2,
            chainLink_USDC_USD: 0x8fFfFfd4AfB6115b954Bd326cbe7B4BA576818f6,
            chainLink_DAI_USDC: 0xAed0c38402a5d19df6E4c03F4E2DceD6e29c1ee9,
            chainLink_ETH_USD: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419,
            chainLink_BTC_USD: 0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c,
            chainLink_LINK_USD: 0x2c1d072e956AFFC0D435Cb7AC38EF18d24d9127c
        });
    }

    function getSepoliaEthConfig()
        public
        pure
        returns (NetworkConfig memory sepoliaNetworkConfig)
    {
        sepoliaNetworkConfig = NetworkConfig({
            feeAddress: 0xf65e0Fd0C77B1182670dD23F8D341c78516C0BB2,
            chainLink_USDC_USD: 0xA2F78ab2355fe2f984D808B5CeE7FD0A93D5270E,
            chainLink_DAI_USDC: 0x14866185B1962B63C3Ea9E03Bc1da838bab34C19,
            chainLink_ETH_USD: 0x694AA1769357215DE4FAC081bf1f309aDC325306,
            chainLink_BTC_USD: 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43,
            chainLink_LINK_USD: 0xc59E3633BAAC79493d908e63626716e204A45EdF
        });
    }
}

// // SPDX-License-Identifier: MIT
// pragma solidity 0.6.10;

// import {Script, console2} from "forge-std/Script.sol";

// abstract contract CodeConstants {
//     address public FOUNDRY_DEFAULT_SENDER =
//         0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38;

//     uint256 public constant ETH_SEPOLIA_CHAIN_ID = 11155111;
//     uint256 public constant ETH_MAINNET_CHAIN_ID = 1;
//     uint256 public constant LOCAL_CHAIN_ID = 31337;
// }
// error HelperConfig__InvalidChainId();
// contract HelperConfig is CodeConstants, Script {


//     struct NetworkConfig {
//         address feeAddress;
//         address chainLink_USDC_USD;
//         address chainLink_DAI_USDC;
//         address chainLink_ETH_USD;
//         address chainLink_BTC_USD;
//         address chainLink_LINK_USD;
//     }

//     // Local network state variables
//     NetworkConfig public localNetworkConfig;
//     mapping(uint256 chainId => NetworkConfig) public networkConfigs;

//     constructor() {
//         networkConfigs[ETH_SEPOLIA_CHAIN_ID] = getSepoliaEthConfig();
//         networkConfigs[ETH_MAINNET_CHAIN_ID] = getMainnetEthConfig();
//     }

//     function getConfig() public returns (NetworkConfig memory) {
//         return getConfigByChainId(block.chainid);
//     }

//     function getConfigByChainId(
//         uint256 chainId
//     ) public returns (NetworkConfig memory) {
//         if (networkConfigs[chainId].vrfCoordinatorV2_5 != address(0)) {
//             return networkConfigs[chainId];
//         } else if (chainId == LOCAL_CHAIN_ID) {
//             return getOrCreateAnvilEthConfig();
//         } else {

//         }
//     }

//     function getMainnetEthConfig()
//         public
//         pure
//         returns (NetworkConfig memory mainnetNetworkConfig)
//     {
//         mainnetNetworkConfig = NetworkConfig({
//             feeAddress: 0x514910771AF9Ca656af840dff83E8264EcF986CA,
//             chainLink_USDC_USD: 0xA2F78ab2355fe2f984D808B5CeE7FD0A93D5270E,
//             chainLink_DAI_USDC: 0x14866185B1962B63C3Ea9E03Bc1da838bab34C19,
//             chainLink_ETH_USD: 0x514910771AF9Ca656af840dff83E8264EcF986CA,
//             chainLink_BTC_USD: 0x514910771AF9Ca656af840dff83E8264EcF986CA,
//             chainLink_LINK_USD: 0x514910771AF9Ca656af840dff83E8264EcF986CA
//         });
//     }

//     function getSepoliaEthConfig()
//         public
//         pure
//         returns (NetworkConfig memory sepoliaNetworkConfig)
//     {
//         sepoliaNetworkConfig = NetworkConfig({
//             feeAddress: 0x514910771AF9Ca656af840dff83E8264EcF986CA,
//             chainLink_USDC_USD: 0xA2F78ab2355fe2f984D808B5CeE7FD0A93D5270E,
//             chainLink_DAI_USDC: 0x14866185B1962B63C3Ea9E03Bc1da838bab34C19,
//             chainLink_ETH_USD: 0x694AA1769357215DE4FAC081bf1f309aDC325306,
//             chainLink_BTC_USD: 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43,
//             chainLink_LINK_USD: 0xc59E3633BAAC79493d908e63626716e204A45EdF
//         });
//     }

//     function getOrCreateAnvilEthConfig() public returns (NetworkConfig memory) {
//         console2.log(unicode"⚠️ You have deployed a mock conract!");
//         console2.log("Make sure this was intentional");

//         localNetworkConfig = NetworkConfig({
//             feeAddress: 0x514910771AF9Ca656af840dff83E8264EcF986CA,
//             chainLink_USDC_USD: 0xA2F78ab2355fe2f984D808B5CeE7FD0A93D5270E,
//             chainLink_DAI_USDC: 0x14866185B1962B63C3Ea9E03Bc1da838bab34C19,
//             chainLink_ETH_USD: 0x694AA1769357215DE4FAC081bf1f309aDC325306,
//             chainLink_BTC_USD: 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43,
//             chainLink_LINK_USD: 0xc59E3633BAAC79493d908e63626716e204A45EdF
//         });
//         //vm.deal(localNetworkConfig.account, 100 ether);
//         return localNetworkConfig;
//     }
// }

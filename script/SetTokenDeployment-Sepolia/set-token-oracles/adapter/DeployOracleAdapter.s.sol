// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;

import {Script, console} from "forge-std/Script.sol";
import {ChainlinkOracleAdapter} from "@setToken/contracts/adapter/ChainlinkOracleAdapter.sol";
import {ContractAddresses} from "./helper/ContractAddresses.sol";
import {AggregatorInterface} from "@setToken/contracts/interfaces/external/IAggregatorInterface.sol";

contract DeployOracleAdapter is Script, ContractAddresses {
    function run() external {
        address chainlinkUSDCAdapter = deployChainlinkOracleAdapter(usdc_usd);
        console.log("USDC-USD adapter %s", address(chainlinkUSDCAdapter));

        address chainlinkDAIAdapter = deployChainlinkOracleAdapter(dai_usdc);
        console.log("DAI-USDC adapter %s", address(chainlinkDAIAdapter));

        address chainlinkETHAdapter = deployChainlinkOracleAdapter(eth_usd);
        console.log("ETH-USD adapter %s", address(chainlinkETHAdapter));

        address chainlinkBTCAdapter = deployChainlinkOracleAdapter(btc_usd);
        console.log("BTC-USD adapter %s", address(chainlinkBTCAdapter));

        address chainlinkLINKAdapter = deployChainlinkOracleAdapter(link_usd);
        console.log("LINK-USD adapter %s", address(chainlinkLINKAdapter));
    }

    function deployChainlinkOracleAdapter(AggregatorInterface oracle) public returns (address) {
        // Private has to be of the manager address mentioned above. Edit it accordingly.
        uint256 deployerPrivateKey = vm.envUint("SET_TOKEN_MANAGER_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        ChainlinkOracleAdapter chainlinkAdapter = new ChainlinkOracleAdapter(oracle);
        vm.stopBroadcast();
        return address(chainlinkAdapter);
    }
}

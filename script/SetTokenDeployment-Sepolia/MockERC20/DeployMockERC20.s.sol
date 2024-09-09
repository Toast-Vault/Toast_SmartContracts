// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {StandardTokenMock} from "@mockERC20/StandardTokenMock.sol";

contract DeployMockErc20 is Script {
    address initialAccount = 0xf65e0Fd0C77B1182670dD23F8D341c78516C0BB2;
    uint256 initialBalance = 1e18;

    function run() external {
        {
            // deploying mock-usdc
            string memory name = "Mock USDC";
            string memory symbol = "M-USDC";
            uint8 decimals = 6;
            address usdcTokenAddress = deployMockToken(name, symbol, decimals);
            console.log("Mock token: %s : %s ", usdcTokenAddress, name);
        }

        {
            // deploying mock-dai
            string memory name = "Mock DAI";
            string memory symbol = "M-DAI";
            uint8 decimals = 6;
            address daiTokenAddress = deployMockToken(name, symbol, decimals);
            console.log("Mock token: %s : %s ", daiTokenAddress, name);
        }

        {
            // deploying mock-dai
            string memory name = "Mock WBTC";
            string memory symbol = "M-WBTC";
            uint8 decimals = 18;
            address wbtcTokenAddress = deployMockToken(name, symbol, decimals);
            console.log("Mock token: %s : %s ", wbtcTokenAddress, name);
        }

        {
            // deploying mock-dai
            string memory name = "Mock LINK";
            string memory symbol = "M-LINK";
            uint8 decimals = 18;
            address linkTokenAddress = deployMockToken(name, symbol, decimals);
            console.log("Mock token: %s : %s ", linkTokenAddress, name);
        }
    }

    function deployMockToken(string memory name, string memory symbol, uint8 decimals) public returns (address) {
        uint256 deployerPrivateKey = vm.envUint("SET_TOKEN_MANAGER_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        StandardTokenMock mockToken = new StandardTokenMock(initialAccount, initialBalance, name, symbol, decimals);
        vm.stopBroadcast();
        return address(mockToken);
    }
}

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {StandardTokenMock} from "@mockERC20/StandardTokenMock.sol";

/**
 * @dev Please make sure there are vars in .env same as .env.example
 * This script will mint the 100 tokens and approve basis module - USER_ONE private key
 * @notice forge script script/setTokenInteraction-Sepolia/MintApproveMockTokens.s.sol --rpc-url $SEPOLIA_URL --broadcast
 */

contract MintApproveMockTokens is Script {
    address constant USDC = 0x473a827b9B50b2a8A711493C9F80CFeE96f3Be97;
    address constant DAI = 0x48feC5d47182698Ec10D1c258d90dC9dB142de41;
    address constant WBTC = 0x714F7a3d1A3F33fB09CE13f5033C0E576Cd0cE8e;
    address constant LINK = 0x5865665E51cA79A6462a88A14179056C73F681E1;
    address constant basicIssuanceModuleAddress =
        0x38Ea574B6dC8229575b195CF77CeCC3C1749E5e5;

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("USER_ONE");
        address deployer = vm.addr(deployerPrivateKey);
        // Mint and approve USDC Token
        mintMockToken(USDC, deployerPrivateKey, deployer);
        approveModule(USDC, deployerPrivateKey);
        balanceOf(USDC, deployer);
        // Mint and approve Dai Token
        mintMockToken(DAI, deployerPrivateKey, deployer);
        approveModule(DAI, deployerPrivateKey);
        balanceOf(DAI, deployer);
        // Mint and approve BTC Token
        mintMockToken(WBTC, deployerPrivateKey, deployer);
        approveModule(WBTC, deployerPrivateKey);
        balanceOf(WBTC, deployer);
        // Mint and approve LINK Token
        mintMockToken(LINK, deployerPrivateKey, deployer);
        approveModule(LINK, deployerPrivateKey);
        balanceOf(LINK, deployer);
    }

    // Minting 100
    function mintMockToken(
        address tokenAddress,
        uint256 privateKey,
        address user
    ) public {
        StandardTokenMock standardTokenMock = StandardTokenMock(tokenAddress);
        string memory name = standardTokenMock.name();
        uint256 mintToken = 100;
        console.log("Minting %s tokens ...", name);
        vm.startBroadcast(privateKey);
        standardTokenMock.mint(user, mintToken);
        vm.stopBroadcast();
        console.log("Finished m,inting %s tokens ...", name);
    }

    function approveModule(address tokenAddress, uint256 privateKey) public {
        StandardTokenMock standardTokenMock = StandardTokenMock(tokenAddress);
        string memory name = standardTokenMock.name();
        console.log("Approving %s tokens ...", name);
        vm.startBroadcast(privateKey);
        standardTokenMock.approve(basicIssuanceModuleAddress, UINT256_MAX);
        vm.stopBroadcast();
        console.log("Finished approving %s tokens ...", name);
    }

    function balanceOf(address tokenAddress, address user) public view {
        StandardTokenMock standardTokenMock = StandardTokenMock(tokenAddress);
        string memory name = standardTokenMock.name();
        uint256 balance = standardTokenMock.balanceOf(user);
        console.log("%s balance is: %s %s", user, balance, name);
    }
}

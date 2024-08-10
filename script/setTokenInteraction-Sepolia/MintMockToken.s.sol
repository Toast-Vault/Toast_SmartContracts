// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import {StandardTokenMock} from "@mockERC20/StandardTokenMock.sol";

/**
 * @dev Please make sure there are var in .env same as .env.example
 * This script will mint the 50 tokens to USER_ONE private key
 * @notice forge script script/setTokenInteraction-Sepolia/MintMockToken.s.sol --rpc-url $SEPOLIA_URL --broadcast
 */

contract MintMockToken is Script {
    address constant DAI = 0x48feC5d47182698Ec10D1c258d90dC9dB142de41;
    address constant WBTC = 0x714F7a3d1A3F33fB09CE13f5033C0E576Cd0cE8e;
    address constant LINK = 0x5865665E51cA79A6462a88A14179056C73F681E1;

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("USER_ONE");
        // Mint Dai Token
        mintMockToken(DAI, deployerPrivateKey);
        // Mint BTC Token
        mintMockToken(WBTC, deployerPrivateKey);
        // Mint LINK Token
        mintMockToken(LINK, deployerPrivateKey);
    }

    // Minting 1000
    function mintMockToken(address tokenAddress, uint256 privateKey) public {
        StandardTokenMock standardTokenMock = StandardTokenMock(tokenAddress);
        address deployer = vm.addr(privateKey);
        uint256 mintToken = 100;
        vm.startBroadcast(privateKey);
        standardTokenMock.mint(deployer, mintToken);
        vm.stopBroadcast();
    }
}

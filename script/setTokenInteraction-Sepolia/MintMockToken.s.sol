// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;
import {Script, console} from "forge-std/Script.sol";
import {StandardTokenMock} from "@mockERC20/StandardTokenMock.sol";
import {ContractAddresses} from "./helper/ContractAddresses.s.sol";

contract MintMockToken is Script, ContractAddresses {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("MANAGER_PRIVATE_KEY");
        mintMockToken(mockUSDC, deployerPrivateKey);
    }

    // Minting 1000
    function mintMockToken(address tokenAddress, uint256 privateKey) public {
        StandardTokenMock standardTokenMock = StandardTokenMock(tokenAddress);
        address deployer = vm.addr(privateKey);
        uint8 decimals = standardTokenMock.decimals();
        uint256 mintToken = 1000 ** decimals;
        vm.startBroadcast(privateKey);
        standardTokenMock.mint(deployer, mintToken);
        vm.stopBroadcast();
    }

    function approve
}

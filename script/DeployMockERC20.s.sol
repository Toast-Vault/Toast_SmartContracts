// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;

import {Script, console} from "forge-std/Script.sol";
import {StandardTokenMock} from "../src/mock/StandardTokenMock.sol";

contract DeployMockErc20 is Script {
    address initialAccount = 0xf65e0Fd0C77B1182670dD23F8D341c78516C0BB2;
    uint256 initialBalance = 1e18;
    string name = "Mock DAI";
    string symbol = "M-DAI";
    uint8 decimals = 6;

    function run() external returns (StandardTokenMock) {
        vm.startBroadcast();
        StandardTokenMock mockToken = new StandardTokenMock(
            initialAccount,
            initialBalance,
            name,
            symbol,
            decimals
        );
        vm.stopBroadcast();

        console.log("Mock token: %s : %s ", address(mockToken), name);
        return mockToken;
    }
}

// forge create src/mock/StandardTokenMock.sol:StandardTokenMock \
// --rpc-url 127.0.0.1:8545 \
// --constructor-args 0xf65e0Fd0C77B1182670dD23F8D341c78516C0BB2 100000 "?M" "m" 18 \
// --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

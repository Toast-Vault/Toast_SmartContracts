// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;

import {Script, console} from "forge-std/Script.sol";
import {SetToken} from "@setToken/contracts/protocol/SetToken.sol";
import {SetValuer} from "@setToken/contracts/protocol/SetValuer.sol";
import {ContractAddresses} from "./helper/ContractAddresses.s.sol";
import {BasicIssuanceModule} from "@setToken/contracts/protocol/modules/v1/BasicIssuanceModule.sol";
import {CustomOracleNavIssuanceModule} from "@setToken/contracts/protocol/modules/v1/CustomOracleNAVIssuanceModule.sol";
import {INAVIssuanceHook} from "@setToken/contracts/interfaces/INAVIssuanceHook.sol";
import {ISetValuer} from "@setToken/contracts/interfaces/ISetValuer.sol";

contract TokenSetConfig is Script, ContractAddresses {
    uint256 mintTokenn = 1;

    function run() external {
        uint256 userOnePrivateKey = vm.envUint("USER_ONE");
        address deployer = vm.addr(userOnePrivateKey);
        balanceOf(deployer);
        mintTokenSet(userOnePrivateKey, deployer);
        balanceOf(deployer);
        getSetTokenPrice();
    }

    // Utilizing BasicIssuance module for minting tokenSet.
    function mintTokenSet(uint256 privateKey, address to) public {
        BasicIssuanceModule basicIssuanceModule = BasicIssuanceModule(
            address(basicIssuanceModuleAddress)
        );
        console.log("Minting token set to %s", to);
        vm.startBroadcast(privateKey);
        basicIssuanceModule.issue(usdcBtcLink, 1, to);
        console.log("Token set has been minted to %s", to);
        vm.stopBroadcast();
    }

    function balanceOf(address userAddress) public view {
        SetToken setToken = SetToken(payable(address(usdcBtcLink)));
        uint256 balance = setToken.balanceOf(userAddress);
        console.log("%s balance is %s", userAddress, balance);
    }

    function getSetTokenPrice() public view {
        SetValuer setValuer = SetValuer(address(setValuerAddress));
        uint256 price = setValuer.calculateSetTokenValuation(
            usdcBtcLink,
            mockUSDC
        );
        console.log("SetToken price in USDC: %s", price);
    }
}

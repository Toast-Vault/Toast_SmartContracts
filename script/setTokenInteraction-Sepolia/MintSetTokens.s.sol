// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;

import {Script, console} from "forge-std/Script.sol";
import {SetToken} from "@setToken/contracts/protocol/SetToken.sol";
import {ISetToken} from "@setToken/contracts/interfaces/ISetToken.sol";
import {SetValuer} from "@setToken/contracts/protocol/SetValuer.sol";
import {ContractAddresses} from "./helper/ContractAddresses.s.sol";
import {BasicIssuanceModule} from "@setToken/contracts/protocol/modules/v1/BasicIssuanceModule.sol";
import {CustomOracleNavIssuanceModule} from "@setToken/contracts/protocol/modules/v1/CustomOracleNAVIssuanceModule.sol";
import {INAVIssuanceHook} from "@setToken/contracts/interfaces/INAVIssuanceHook.sol";
import {ISetValuer} from "@setToken/contracts/interfaces/ISetValuer.sol";

// Use this script to mint 1 new settokens.
// forge script script/setTokenInteraction-Sepolia/MintSetTokens.s.sol --rpc-url $SEPOLIA_URL --broadcast
contract MintSetTokens is Script, ContractAddresses {
    uint256 mintToken = 1e18;

    function run() external {
        uint256 userOnePrivateKey = vm.envUint("USER_ONE");
        address deployer = vm.addr(userOnePrivateKey);
        balanceOf(deployer);
        mintTokenSet(userOnePrivateKey, deployer);
        balanceOf(deployer);
        getSetTokenPrice();
        totalSupply();
    }

    // Utilizing BasicIssuance module for minting tokenSet.
    function mintTokenSet(uint256 privateKey, address to) public {
        BasicIssuanceModule basicIssuanceModule = BasicIssuanceModule(address(basicIssuanceModuleAddress));
        console.log("Minting token set to %s", to);
        vm.startBroadcast(privateKey);
        basicIssuanceModule.issue(usdcBtcLink, mintToken, to);
        console.log("Token set has been minted to %s", to);
        vm.stopBroadcast();
    }

    function balanceOf(address userAddress) public view {
        SetToken setToken = SetToken(payable(address(usdcBtcLink)));
        uint256 balance = setToken.balanceOf(userAddress);
        console.log("%s balance is %s", userAddress, balance);
    }

    function totalSupply() public view returns (uint256 supply) {
        SetToken setToken = SetToken(payable(address(usdcBtcLink)));
        supply = setToken.totalSupply();
        console.log("Total supply: %s", supply);
    }

    function getSetTokenPrice() public view {
        SetValuer setValuer = SetValuer(address(setValuerAddress));
        uint256 price = setValuer.calculateSetTokenValuation(usdcBtcLink, address(wEth));
        console.log("SetToken price in ETH: %s", price);

        price = setValuer.calculateSetTokenValuation(usdcBtcLink, mockWBTC);
        console.log("SetToken price in BTC: %s", price);

        price = setValuer.calculateSetTokenValuation(usdcBtcLink, mockDAI);
        console.log("SetToken price in DAI: %s", price / 1e18);

        price = setValuer.calculateSetTokenValuation(usdcBtcLink, mockUSDC);
        console.log("SetToken price in USDC: %s", price / 1e18);
    }
}

// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;

import {Script, console} from "forge-std/Script.sol";
import {CustomOracleNavIssuanceModule} from "@setToken/contracts/protocol/modules/v1/CustomOracleNAVIssuanceModule.sol";
import {SetToken} from "@setToken/contracts/protocol/SetToken.sol";
import {ISetToken} from "@setToken/contracts/interfaces/ISetToken.sol";
import {ContractAddresses} from "../helper/ContractAddresses.s.sol";

/**
 * @dev Please make sure there are vars in .env same as .env.example
 * This script will mint the 100 tokens and approve basis module - USER_ONE private key
 * @notice forge script script/setTokenInteraction-Sepolia/MintApproveMockTokens.s.sol --rpc-url $SEPOLIA_URL --broadcast
 */

contract NavIssuanceModuleUSDC is Script, ContractAddresses {
    uint256 usdcValue = 200e6;

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("USER_ONE");
        address deployer = vm.addr(deployerPrivateKey);
        uint256 balance = balanceOf(usdcBtcLink, deployer);
        console.log("Balance before minting: %s", balance);
        uint256 supply = totalSupply(usdcBtcLink);
        console.log("totalSupply: %s", supply);
        // Mint tokenSet with USDC
        mintTokenSet(
            deployerPrivateKey,
            usdcBtcLink,
            mockUSDC,
            usdcValue,
            deployer
        );

        balance = balanceOf(usdcBtcLink, deployer);
        console.log("Balance after minting: %s", balance);
        supply = totalSupply(usdcBtcLink);
        console.log("totalSupply: %s", supply);
    }

    function mintTokenSet(
        uint256 privateKey,
        ISetToken setToken,
        address reserveAsset,
        uint256 reserveAssetQuantity,
        address to
    ) public {
        CustomOracleNavIssuanceModule customOracleNavIssuanceModule = CustomOracleNavIssuanceModule(
                payable(customOracleNavIssuanceModuleAddress)
            );
        uint256 minAmount = getMinSetTokenReceiveQuantity(
            setToken,
            reserveAsset,
            reserveAssetQuantity
        );
        vm.startBroadcast(privateKey);
        customOracleNavIssuanceModule.issue(
            setToken,
            reserveAsset,
            reserveAssetQuantity,
            minAmount,
            to
        );
        vm.stopBroadcast();
        console.log();
    }

    function getMinSetTokenReceiveQuantity(
        ISetToken setToken,
        address reserveAsset,
        uint256 reserveAssetQuantity
    ) public view returns (uint256 minAmount) {
        CustomOracleNavIssuanceModule customOracleNavIssuanceModule = CustomOracleNavIssuanceModule(
                payable(customOracleNavIssuanceModuleAddress)
            );

        minAmount = customOracleNavIssuanceModule
            .getExpectedSetTokenIssueQuantity(
                setToken,
                reserveAsset,
                reserveAssetQuantity
            );
        console.log("Min amount: %s", minAmount);
        return minAmount;
    }

    function totalSupply(
        ISetToken setTokenAddress
    ) public view returns (uint256) {
        SetToken setToken = SetToken(payable(address(setTokenAddress)));
        return setToken.totalSupply();
    }

    function balanceOf(
        ISetToken setTokenAddress,
        address userAddress
    ) public view returns (uint256) {
        SetToken setToken = SetToken(payable(address(setTokenAddress)));
        return setToken.balanceOf(userAddress);
    }
}

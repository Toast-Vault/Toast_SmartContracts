// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.6.10;

import {Script, console} from "forge-std/Script.sol";
import {CustomOracleNavIssuanceModule} from "@setToken/contracts/protocol/modules/v1/CustomOracleNAVIssuanceModule.sol";
import {SetToken} from "@setToken/contracts/protocol/SetToken.sol";
import {ISetToken} from "@setToken/contracts/interfaces/ISetToken.sol";
import {ContractAddresses} from "../helper/ContractAddresses.s.sol";

/**
 * @dev Please make sure there are vars in .env same as .env.example. And USER_ONE has setTokens to redeem. User cannot redeem more than reserve assest units in a vault.
 * This script will redeem tokenSet to reserve - USER_ONE private key
 * @notice forge script script/setTokenInteraction-Sepolia/NavIssuanceModule/NavIssuanceModuleRedeem.s.sol --rpc-url $SEPOLIA_URL --broadcast
 */
contract NavIssuanceModuleRedeem is Script, ContractAddresses {
    uint256 setTokenQunatity = 1e17;

    function run() external {
        uint256 deployerPrivateKey = vm.envUint("USER_ONE");
        address deployer = vm.addr(deployerPrivateKey);
        uint256 balance = balanceOf(usdcBtcLink, deployer);
        console.log("Balance before minting: %s", balance);
        uint256 supply = totalSupply(usdcBtcLink);
        console.log("totalSupply: %s", supply);
        uint256 unit = getDefaultPositionRealUnit(usdcBtcLink, mockUSDC);
        console.log("Real unit USDC: %s", unit / 1e6);
        unit = getDefaultPositionRealUnit(usdcBtcLink, mockWBTC);
        console.log("Real unit BTC: %s", unit);
        unit = getDefaultPositionRealUnit(usdcBtcLink, mockLINK);
        console.log("Real unit LINK: %s", unit / 1e18);
        // Redeem token set to reserve asset
        redeemTokenSet(deployerPrivateKey, usdcBtcLink, mockUSDC, setTokenQunatity, deployer);

        balance = balanceOf(usdcBtcLink, deployer);
        console.log("Balance after minting: %s", balance);
        supply = totalSupply(usdcBtcLink);
        console.log("totalSupply: %s", supply);
    }

    function redeemTokenSet(
        uint256 privateKey,
        ISetToken setToken,
        address reserveAsset,
        uint256 setTokenQuantity,
        address to
    ) public {
        CustomOracleNavIssuanceModule customOracleNavIssuanceModule =
            CustomOracleNavIssuanceModule(payable(customOracleNavIssuanceModuleAddress));
        uint256 minAmount = getMinReserveAssetReceiveQuantity(setToken, reserveAsset, setTokenQuantity);
        vm.startBroadcast(privateKey);
        customOracleNavIssuanceModule.redeem(setToken, reserveAsset, setTokenQuantity, minAmount, to);
        vm.stopBroadcast();
    }

    function getMinReserveAssetReceiveQuantity(ISetToken setToken, address reserveAsset, uint256 setTokenQuantity)
        public
        view
        returns (uint256 minAmount)
    {
        CustomOracleNavIssuanceModule customOracleNavIssuanceModule =
            CustomOracleNavIssuanceModule(payable(customOracleNavIssuanceModuleAddress));

        minAmount =
            customOracleNavIssuanceModule.getExpectedReserveRedeemQuantity(setToken, reserveAsset, setTokenQuantity);
        console.log("Min amount: %s", minAmount);
        return minAmount;
    }

    function getDefaultPositionRealUnit(ISetToken setTokenAddress, address token) public view returns (uint256) {
        SetToken setToken = SetToken(payable(address(setTokenAddress)));
        uint256 unit = uint256(setToken.getDefaultPositionRealUnit(token));
        return unit;
    }

    function totalSupply(ISetToken setTokenAddress) public view returns (uint256) {
        SetToken setToken = SetToken(payable(address(setTokenAddress)));
        return setToken.totalSupply();
    }

    function balanceOf(ISetToken setTokenAddress, address userAddress) public view returns (uint256) {
        SetToken setToken = SetToken(payable(address(setTokenAddress)));
        return setToken.balanceOf(userAddress);
    }
}

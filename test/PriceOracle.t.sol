pragma solidity ^0.6.10;
pragma experimental ABIEncoderV2;

import {Test, console} from "forge-std/Test.sol";
import {PriceOracle} from "@setToken/contracts/protocol/PriceOracle.sol";
import {DeployPriceOracle} from "../script/SetTokenDeployment-Sepolia/set-token-oracles/DeployPriceOracle.s.sol";
import {ContractAddresses} from "../script/SetTokenDeployment-Sepolia/set-token-oracles/helper/ContractAddresses.sol";
import {IPyth} from "@setToken/contracts/interfaces/external/IPyth.sol";
import {PythStructs} from "@setToken/contracts/interfaces/external/PythStructs.sol";

contract PriceOracleTest is Test, ContractAddresses {
    uint256 constant multiplier = 1e10;
    uint256 sepoliaFork;
    PriceOracle priceOracle;
    IPyth pyth;

    modifier checkFork() {
        require(vm.activeFork() == sepoliaFork);
        _;
    }

    function setUp() public {
        string memory sepoliaUrl = vm.envString("SEPOLIA_URL");
        sepoliaFork = vm.createFork(sepoliaUrl);
        vm.selectFork(sepoliaFork);
        DeployPriceOracle deployer = new DeployPriceOracle();
        pyth = pythAddress;
        priceOracle = deployer.run();
    }

    function testWethUsdcOracleId() public view checkFork {
        bytes32 oracleId = priceOracle.oracles(weth, usdc);
        assertEq(oracleId, eth_usd);
    }

    function testWethUsdcPrice() public view checkFork {
        uint256 oraclePrice = priceOracle.getPrice(weth, usdc);
        PythStructs.Price memory priceStruct = pyth.getPriceUnsafe(eth_usd);
        assertEq(oraclePrice, uint256(priceStruct.price) * multiplier);
    }
}

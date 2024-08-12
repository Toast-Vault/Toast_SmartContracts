## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
## Sepolia Testnet

### Token Set

#### [0x6ecF9bBf7038c6Ca131fC73197B89993942eb5bb](https://sepolia.etherscan.io/address/0x6ecF9bBf7038c6Ca131fC73197B89993942eb5bb)
##### Above contract created at [tx](https://sepolia.etherscan.io/tx/0x9514876761298121a18502ac509d654e5df1eff1b7f1b12a34f9b82b5d6bc953)

####    Transactions
    "function": "create(address[],int256[],address[],address,string,string)",
      "arguments": [
        "[0x473a827b9B50b2a8A711493C9F80CFeE96f3Be97, 0x714F7a3d1A3F33fB09CE13f5033C0E576Cd0cE8e, 0x5865665E51cA79A6462a88A14179056C73F681E1]",
        "[50000000, 10000000000000000, 25000000000000000000]",
        "[0x38Ea574B6dC8229575b195CF77CeCC3C1749E5e5, 0x6D06248e18d2A713912CeDE4203213ce15307Ca0]",
        "0xfeB42b6c3c4250F435c20cFF22eA2FE386A830F2",
        "\"BTC_USDC_LINK\"",
        "\"BUL\""
      ],


### Mock token Contracts

#### WETH: [0x295349FBB6de65686382b20189632434894Ebe42](https://sepolia.etherscan.io/address/0x295349FBB6de65686382b20189632434894Ebe42)

#### Mock-DAI: [0x48feC5d47182698Ec10D1c258d90dC9dB142de41](https://sepolia.etherscan.io/address/0x48feC5d47182698Ec10D1c258d90dC9dB142de41)

#### Mock-USDC: [0x473a827b9B50b2a8A711493C9F80CFeE96f3Be97](https://sepolia.etherscan.io/address/0x473a827b9B50b2a8A711493C9F80CFeE96f3Be97)

#### Mock-WBTC: [0x714F7a3d1A3F33fB09CE13f5033C0E576Cd0cE8e](https://sepolia.etherscan.io/address/0x714F7a3d1A3F33fB09CE13f5033C0E576Cd0cE8e)

#### Mock-LINK: [0x5865665E51cA79A6462a88A14179056C73F681E1](https://sepolia.etherscan.io/address/0x5865665E51cA79A6462a88A14179056C73F681E1)

### Core Contracts

#### Controller: [0x9Df9fef12Fa512315CC9F3e5C1D2faFf1bB04a72](https://sepolia.etherscan.io/address/0x9Df9fef12Fa512315CC9F3e5C1D2faFf1bB04a72)

#### Integration Registry: [0x2Fb11ea7CEE5e62E4709BB7BE420C4EaBfA3ea0A](https://sepolia.etherscan.io/address/0x2Fb11ea7CEE5e62E4709BB7BE420C4EaBfA3ea0A)

#### SetToken creator: [0x7c4Bb129E929A955e36137144607Fb32be52b804.](https://sepolia.etherscan.io/address/0x7c4Bb129E929A955e36137144607Fb32be52b804)

#### Set valuer: [0x012d6bC94051C3b9F923c043A51D381903EAC16A](https://sepolia.etherscan.io/address/0x012d6bC94051C3b9F923c043A51D381903EAC16A)

#### Price Oracle: [0x49ad1B642318202A5b20513B826918A328D8D6E4](https://sepolia.etherscan.io/address/0x49ad1B642318202A5b20513B826918A328D8D6E4)

### Modules

#### BasicIssuanceModule: [0x38Ea574B6dC8229575b195CF77CeCC3C1749E5e5](https://sepolia.etherscan.io/address/0x38Ea574B6dC8229575b195CF77CeCC3C1749E5e5)

#### GeneralIndexModule:[0x6D06248e18d2A713912CeDE4203213ce15307Ca0](https://sepolia.etherscan.io/address/0x6D06248e18d2A713912CeDE4203213ce15307Ca0) Not verified yet.

#### CustomOracleNavIssuanceModule: [0x392F1587db195283E247CeECe541c6a744C3E7D7](https://sepolia.etherscan.io/address/0x392f1587db195283e247ceece541c6a744c3e7d7)

### Chainlink oracle adpater

#### USDC-USD adpter [0xd9DC501B9E4437683ABfe83B377748Af7265b562.](https://sepolia.etherscan.io/address/0xd9DC501B9E4437683ABfe83B377748Af7265b562.)

#### DAI-USDC adpter [0xdc51ab0258B5ff93E2CEea0cf6aAD6937E346FE0](https://sepolia.etherscan.io/address/0xdc51ab0258B5ff93E2CEea0cf6aAD6937E346FE0)

#### ETH-USD adpter [0xeD7A35c4Ee06ea4e3203471d1b022019849F8EDA](https://sepolia.etherscan.io/address/0xeD7A35c4Ee06ea4e3203471d1b022019849F8EDA)

#### BTC-USD adapter [0x5920257792dBba08dfadD34607B781E3C2CDb3cF](https://sepolia.etherscan.io/address/0x5920257792dbba08dfadd34607b781e3c2cdb3cf)

#### LINK-USD adapter [0x6aE07395E64A0bEd5529e170C1A0b667E05D4Ad3](https://sepolia.etherscan.io/address/0x6aE07395E64A0bEd5529e170C1A0b667E05D4Ad3)

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

#### Price Oracle: [0x49ad1B642318202A5b20513B826918A328D8D6E4](https://sepolia.etherscan.io/address/0x012d6bC94051C3b9F923c043A51D381903EAC16A)

### Modules

#### BasicIssuanceModule: [0x38ea574b6dc8229575b195cf77cecc3c1749e5e5](https://sepolia.etherscan.io/address/0x38ea574b6dc8229575b195cf77cecc3c1749e5e5)

#### GeneralIndexModule:[0x6D06248e18d2A713912CeDE4203213ce15307Ca0](https://sepolia.etherscan.io/address/0x6D06248e18d2A713912CeDE4203213ce15307Ca0) Not verified yet.

### Chainlink oracle adpater

#### USDC-USD adpter [0xE3e0c9a4f088C754c381d161d67A596721E613aB](https://sepolia.etherscan.io/address/0xE3e0c9a4f088C754c381d161d67A596721E613aB)

#### DAI-USDC adpter [0x5934DE42541C7eF4860095d37344B71042c1706C](https://sepolia.etherscan.io/address/0x5934DE42541C7eF4860095d37344B71042c1706C)

#### ETH-USD adpter [0x49ad1B642318202A5b20513B826918A328D8D6E4](https://sepolia.etherscan.io/address/0x5934DE42541C7eF4860095d37344B71042c1706C)

#### BTC-USD adapter [0x295349FBB6de65686382b20189632434894Ebe42](https://sepolia.etherscan.io/address/0x295349FBB6de65686382b20189632434894Ebe42)

#### LINK-USD adapter [0x0a2658f1Fb8C8b734635A49dE6209c243c42b7F0](https://sepolia.etherscan.io/address/0x0a2658f1Fb8C8b734635A49dE6209c243c42b7F0)

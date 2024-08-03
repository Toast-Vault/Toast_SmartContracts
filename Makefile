-include .env

build:; forge build

deploy-sepolia-mERC20:
	forge script script/DeployMockERC20.s.sol:DeployMockErc20 --rpc-url $(SEPLOIA_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

deploy-sepolia-controller:
	forge script script/set-tokens-core/DeployController.s.sol:DeployController --rpc-url $(SEPLOIA_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

deploy-sepolia-integrationRegistry:
	forge script script/set-tokens-core/DeployIntegrationRegistry.s.sol:DeployIntegrationRegistry --rpc-url $(SEPLOIA_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

deploy-sepolia-setTokenCreator:
	forge script script/set-tokens-core/DeploySetTokenCreator.s.sol:DeploySetTokenCreator --rpc-url $(SEPLOIA_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

deploy-sepolia-setValuer:
	forge script script/set-tokens-core/DeploySetValuer.s.sol:DeploySetValuer --rpc-url $(SEPLOIA_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

deploy-sepolia-oracleAdpter:
	forge script script/DeployOracleAdapter.s.sol:DeployOracleAdapter --rpc-url $(SEPLOIA_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

deploy-sepolia-PriceOracle:
	forge script script/DeployPriceOracle.s.sol:DeployPriceOracle --rpc-url $(SEPLOIA_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
-include .env

build:; forge build

deploy-sepolia-fork:
	anvil --rpc-url $(SEPOLIA_URL)

deploy-sepolia-mERC20:
	forge script script/setTokenDeployment-Sepolia/MockERC20/DeployMockERC20.s.sol:DeployMockErc20 --rpc-url $(SEPOLIA_URL) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

deploy-sepolia-WETH:
	forge script script/setTokenDeployment-Sepolia/MockERC20/DeployMockWETH.s.sol:DeployMockWETH --rpc-url $(SEPOLIA_URL) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

deploy-sepolia-controller:
	forge script script/setTokenDeployment-Sepolia/set-tokens-core/DeployController.s.sol:DeployController --rpc-url $(SEPOLIA_URL) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

deploy-sepolia-integrationRegistry:
	forge script script/setTokenDeployment-Sepolia/set-tokens-core/DeployIntegrationRegistry.s.sol:DeployIntegrationRegistry --rpc-url $(SEPOLIA_URL) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

deploy-sepolia-setTokenCreator:
	forge script script/setTokenDeployment-Sepolia/set-tokens-core/DeploySetTokenCreator.s.sol:DeploySetTokenCreator --rpc-url $(SEPOLIA_URL) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

deploy-sepolia-setValuer:
	forge script script/setTokenDeployment-Sepolia/set-tokens-core/DeploySetValuer.s.sol:DeploySetValuer --rpc-url $(SEPOLIA_URL)--broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

deploy-sepolia-oracleAdpter:
	forge script script/setTokenDeployment-Sepolia/set-token-oracles/adapter/DeployOracleAdapter.s.sol:DeployOracleAdapter --rpc-url $(SEPOLIA_URL)--broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

deploy-sepolia-priceOracle:
	forge script script/setTokenDeployment-Sepolia/set-token-oracles/DeployPriceOracle.s.sol:DeployPriceOracle --rpc-url $(SEPOLIA_URL) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

deploy-sepolia-generalIndexModule:
	forge script script/setTokenDeployment-Sepolia/set-tokens-modules/DeployGeneralIndexModule.s.sol:DeployGeneralIndexModule --rpc-url $(SEPOLIA_URL) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

deploy-sepolia-basicIssuanceModule:
	forge script script/setTokenDeployment-Sepolia/set-tokens-modules/DeployBasicIssuanceModule.s.sol:DeployBasicIssuanceModule --rpc-url $(SEPOLIA_URL) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv

deploy-sepolia-customOracleNavIssuanceModule:
	forge script script/setTokenDeployment-Sepolia/set-tokens-modules/DeployCustomOracleNavIssuanceModule.s.sol:DeployCustomOracleNavIssuanceModule --rpc-url $(SEPOLIA_URL) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
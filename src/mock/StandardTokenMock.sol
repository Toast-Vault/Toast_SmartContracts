// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin-V8/contracts/token/ERC20/ERC20.sol";

// mock class using BasicToken
contract StandardTokenMock is ERC20 {
    uint8 private _decimals;

    constructor(
        address _initialAccount,
        uint256 _initialBalance,
        string memory _name,
        string memory _symbol,
        uint8 _decimal
    ) ERC20(_name, _symbol) {
        _mint(_initialAccount, _initialBalance);
        _decimals = _decimal;
    }

    function mint(address to, uint amount) external {
        _mint(to, amount);
    }

    function decimals() public view virtual override returns (uint8) {
        return _decimals;
    }
}

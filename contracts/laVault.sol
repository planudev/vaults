//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./ERC20.sol";
import "./interfaces/IERC20.sol";
import "./interfaces/IVault.sol";
import "./libraries/SafeERC20.sol";

contract laVault is ERC20, IVault {
    using SafeERC20 for IERC20;

    IERC20 public token;

    constructor(address _token) 
        ERC20(
            string(abi.encodePacked("sonic ", ERC20(_token).name())),
            string(abi.encodePacked("so", ERC20(_token).symbol()))
        ) 
    {
        token = IERC20(_token);
    }

    function balance() internal view returns (uint) {
        return balanceOf(address(this));
    }

    function getPricePerFullShare() external override view returns (uint) {
        return (balance() * 1e18) / totalSupply();
    }

    function deposit(uint256 _amount) public override {

    }

    function depositAll() external override {
        deposit(token.balanceOf(msg.sender));
    }

    function withdraw(uint256 _amount) public override {

    }

    function withdrawAll() external override {
        withdraw(balanceOf(msg.sender));
    }
}
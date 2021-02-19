//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./ERC20.sol";
import "./interfaces/IERC20.sol";
import "./interfaces/IVault.sol";
import "./interfaces/IController.sol";
import "./libraries/SafeERC20.sol";

contract pVault is ERC20, IVault {
    using SafeERC20 for IERC20;

    IERC20 public token;

    address public controller;

    constructor(address _token, address _controller) 
        ERC20(
            string(abi.encodePacked("planu ", ERC20(_token).name())),
            string(abi.encodePacked("p", ERC20(_token).symbol()))
        )
    {
        token = IERC20(_token);
        controller = _controller;
    }

    function balance() public view returns (uint) {
        return token.balanceOf(address(this)) + IController(controller).balanceOf(token);
    }

    function available() public view returns (uint) {
        return token.balanceOf(address(this));
    }

    function getPricePerFullShare() external override view returns (uint) {
        return (balance() * 1e18) / totalSupply();
    }

    function invest() internal {
        // TODO [$602f78e3832b910974b70f64]: Maybe need to check for minimum invest something like
        // if it have more than 0.1 Tokens then invest to save gas fee
        uint256 availableBalance = available();
        token.safeTransfer(controller, availableBalance);
        IController(controller).invest(address(token), availableBalance);
    }

    function deposit(uint256 _amount) public override {
        uint256 pool = balance();
        uint256 _before = token.balanceOf(address(this));
        token.safeTransferFrom(msg.sender, address(this), _amount);
        uint256 _after = token.balanceOf(address(this));
        
        uint256 amount = _after - _before;
        uint256 shares = 0;

        if (totalSupply() == 0) {
            shares = amount;
        } else {
            shares = (amount * totalSupply()) / pool; // (amount / (pool / totalSupply))
        }

        _mint(msg.sender, shares);
        invest();
    }

    function depositAll() external override {
        deposit(token.balanceOf(msg.sender));
    }

    function withdraw(uint256 _shares) public override {
        uint256 exchangeRate = balance() / totalSupply();
        uint256 claimAmount = _shares * exchangeRate;
        _burn(msg.sender, _shares);

        uint256 currentBalance = token.balanceOf(address(this));

        if (currentBalance < claimAmount) {
            IController(controller).withdraw(address(token), claimAmount - currentBalance);
        }

        token.safeTransfer(msg.sender, claimAmount);
        invest();
    }

    function withdrawAll() external override {
        withdraw(balanceOf(msg.sender));
    }
}
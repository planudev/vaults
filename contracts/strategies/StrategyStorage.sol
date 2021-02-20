//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../interfaces/IBEP20.sol";
import "../interfaces/IController.sol";

contract StrategyStorage {

    address public controller;
    uint256 internal _withdrawalFee = 50;
    uint256 internal withdrawalMax = 10000;

    modifier onlyController {
        require(msg.sender == controller, "Not a controller!");
        _;
    }

    function setController(address newController) external onlyController {
        controller = newController;
    }

    function setWithdrawalFee(uint256 withdrawalFee) external onlyController {
        _withdrawalFee = withdrawalFee;
    }

    function vaults(address underlying) public view returns (address) {
        return IController(controller).vaults(underlying);
    }

    function getFee(uint amount) public view returns (uint) {
        return amount * _withdrawalFee / withdrawalMax;
    }

    function _sendToVaultWithFee(address underlying, uint amount) internal {
        uint256 fee = getFee(amount);
        uint256 theRestAmount = amount - fee;
        address rewards = IController(controller).rewards();
        IBEP20(underlying).transfer(rewards, fee);

        _sendToVault(underlying, theRestAmount);
    }

    function _sendToVault(address underlying, uint amount) internal {
        address vault = vaults(underlying);
        require(vault != address(0), "!vault");
        IBEP20(underlying).transfer(vault, amount);
    }
}

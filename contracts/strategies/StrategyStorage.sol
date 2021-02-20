//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StrategyStorage {

    address public controller;
    uint256 public withdrawalFee;

    modifier onlyController {
        require(msg.sender == controller, "Not a controller!");
        _;
    }

    function setController(address newController) external onlyController {
        controller = newController;
    }

    function setWithdrawalFee(uint256 _withdrawalFee) external onlyController {
        withdrawalFee = _withdrawalFee;
    }
}

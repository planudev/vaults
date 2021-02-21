// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./interfaces/IStrategy.sol";
import "./interfaces/IERC20.sol";
import "./interfaces/IController.sol";
import "./interfaces/compound/Token.sol";
import "./libraries/SafeERC20.sol";

contract StrategyCreamBUSD is IStrategy {
    using SafeERC20 for IERC20;

    // BUSD
    address public override constant want = address(0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56);

    address public constant crBUSD = address(0x2Bc4eb013DDee29D37920938B96d353171289B7C);

    uint256 public override withdrawalFee = 25;

    address public controller;
    address public strategist;

    constructor(address _controller) {
        controller = _controller;
        strategist = msg.sender;
    }

    function getName() external pure returns (string memory) {
        return "StrategyCreamBUSD";
    }

    function setStrategist(address _strategist) external {
        require(msg.sender == strategist, "!strategist");
        strategist = _strategist;
    }

    function withdraw(uint256 _amount) external override {
        require(msg.sender == controller, "!controller");
        uint256 balance = IERC20(want).balanceOf(address(this));
        if (balance < _amount) {
            _amount = _withdrawSome(_amount - balance);
            _amount = _amount + balance;
        }

        // TODO [#4]: send fee to platform tresury
        // uint256 _fee = _amount * withdrawalFee / 100;
        // IERC20(want).safeTransfer(IController(controller).rewards(), _fee);

        address _vault = IController(controller).vaults(address(want));
        IERC20(want).safeTransfer(_vault, _amount);
    }

    function _withdrawC(uint256 _amount) internal {
        cToken(crBUSD).redeem(_amount);
    }

    function _withdrawSome(uint256 _amount) internal returns (uint256) {
        uint256 b = balanceC();
        uint256 bT = balanceCInToken();

        uint256 amount = ((b * _amount) / bT) + 1;
        uint256 _before = IERC20(want).balanceOf(address(this));
        _withdrawC(amount);
        uint256 _after = IERC20(want).balanceOf(address(this));
        uint256 _withdraw = _after - _before;
        return _withdraw;
    }

    function withdrawAll() external override returns (uint256 balance) {
        // TODO [#5]: withdrawAll in StrategyCreamBUSD not implemented yet.
        // this function is for controller so we will be omit it for now.
        return 0;
    }

    function deposit() public override {
        uint256 wantBalance = IERC20(want).balanceOf(address(this));
        if (wantBalance > 0) {
            IERC20(want).safeApprove(crBUSD, 0);
            IERC20(want).safeApprove(crBUSD, wantBalance);
            cToken(crBUSD).mint(wantBalance);
        }
    }

    function balanceOfWant() public view returns (uint256) {
        return IERC20(want).balanceOf(address(this));
    }

    function balanceC() public view returns (uint256) {
        return IERC20(crBUSD).balanceOf(address(this));
    }

    function balanceCInToken() public view returns (uint256) {
        uint256 balance = balanceC();
        if (balance > 0) {
            balance = (balance * cToken(crBUSD).exchangeRateStored()) / 1e18;
        }

        return balance;
    }

    function balanceOf() public override view returns (uint256) {
        return balanceOfWant() + balanceCInToken();
    }

    function annualPercentageYield() public override view returns (uint256) {
        // TODO [#6]: Find APY for CreamBUSD
        return 0;
    }
}
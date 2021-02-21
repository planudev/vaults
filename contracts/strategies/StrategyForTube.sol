//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./StrategyStorage.sol";
import "../interfaces/IBank.sol";
import "../interfaces/IBEP20.sol";
import "../interfaces/IFToken.sol";
import "../interfaces/IStrategy.sol";
import "../interfaces/IInterestRateModelForTube.sol";

contract StrategyStorageForTube is StrategyStorage {

    address internal _bankAddress = address(0x0cEA0832e9cdBb5D476040D58Ea07ecfbeBB7672);
    address internal _interestRateAddress = address(0xb932d9f1641C0f8181117944FB8Ac3e41c837fdC);
    function _deposit(address underlying, uint256 amount) internal {
        IBank(_bankAddress).deposit(underlying, amount);
    }

    function _redeem(address underlying, uint256 amount) internal returns (uint) {
        IBank(_bankAddress).withdraw(underlying, amount);
        return amount;
    }

    function _balanceOfUnderlying(address underlying) internal view returns (uint256) {
        return IBEP20(underlying).balanceOf(address(this));
    }

    function _balanceOfFToken(address fToken) internal view returns (uint256) {
        return IFToken(fToken).balanceOf(address(this));
    }

    function _balanceOfFTokenInUnderlying(address fToken) internal view returns (uint256) {
        uint256 balanceOfFToken = _balanceOfFToken(fToken);
        if (balanceOfFToken > 0)
            balanceOfFToken = balanceOfFToken * _getExchangeRate(fToken) / 1e18;
        return balanceOfFToken;
    }

    function _underlyingDecimals(address underlying) internal view returns (uint) {
        return IBEP20(underlying).decimals();
    }

    function _fTokenDecimals(address fToken) internal view returns (uint) {
        return IFToken(fToken).decimals();
    }

    function _getExchangeRate(address fToken) internal view returns (uint256) {
        return IFToken(fToken).exchangeRateStored();
    }

    function _supplyRatePerBlock(address underlying, address fToken) internal view returns (uint256) {
        uint cash = IFToken(fToken).tokenCash(underlying, address(controller));
        uint totalBorrows = IFToken(fToken).totalBorrows();
        uint totalReserves = IFToken(fToken).totalReserves();
        uint reserveFactor = IFToken(fToken).reserveFactor();

        return IInterestRateModel(_interestRateAddress).getSupplyRate(
            cash,
            totalBorrows,
            totalReserves,
            reserveFactor
        );
    }
}



contract StrategyForTube is StrategyStorageForTube, IStrategy {

    address internal _want;
    address internal _fToken;

    function want() external override view returns (address) {
        return _want;
    }

    function deposit() external override {
        uint256 balanceOfUnderlying = _balanceOfUnderlying(_want);
        if (balanceOfUnderlying > 0) {
            _deposit(_want, balanceOfUnderlying);
        }
    }

    function withdraw(uint256 amount) external override {
        _redeem(_want, amount);
        _sendToVaultWithFee(_want, amount);
    }

    function withdrawAll() external override returns (uint256) {
        uint256 balanceOfFToken = _balanceOfFToken(_fToken);
        if (balanceOfFToken > 0) {
            _redeem(_want, balanceOfFToken);
        }

        uint256 balanceOfUnderlying = _balanceOfUnderlying(_want);
        _sendToVault(_want, balanceOfUnderlying);
        return balanceOfUnderlying;
    }

    function balanceOf() external override view returns (uint256) {
        return _balanceOfUnderlying(_want) + _balanceOfFTokenInUnderlying(_fToken);
    }

    function withdrawalFee() external override view returns (uint256) {
        return _withdrawalFee;
    }
    
    function supplyRatePerBlock() external override view returns (uint256) {
        return _supplyRatePerBlock(_want, _fToken);
    }
}

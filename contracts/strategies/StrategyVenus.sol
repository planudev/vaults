//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./StrategyStorage.sol";
import "../interfaces/IBEP20.sol";
import "../interfaces/IVToken.sol";
import "../interfaces/IStrategy.sol";

import "hardhat/console.sol";

contract StrategyStorageVenus is StrategyStorage {
    
    function _deposit(address underlying, address vToken, uint256 amount) internal {
        IBEP20(underlying).approve(vToken, 0);
        IBEP20(underlying).approve(vToken, amount);
        VBep20Interface(vToken).mint(amount);
    }

    function _redeem(address vToken, uint256 amount) internal returns (uint) {
        return VBep20Interface(vToken).redeem(amount);
    }

    function _balanceOfUnderlying(address underlying) internal view returns (uint256) {
        // console.log("venus balanceOfUnderlying: ", IBEP20(underlying).balanceOf(address(this)));
        return IBEP20(underlying).balanceOf(address(this));
    }

    function _balanceOfVToken(address vToken) internal view returns (uint256) {
        return VTokenInterface(vToken).balanceOf(address(this));
    }

    function _balanceOfVTokenInUnderlying(address vToken) internal view returns (uint256) {
        uint256 exchangeRate = _getExchangeRate(vToken);
        uint256 balanceOfVToken = _balanceOfVToken(vToken);
        console.log("balanceOfVToken: ", balanceOfVToken);
        if (balanceOfVToken > 0)
            console.log("exchangeRate: ", exchangeRate);
            balanceOfVToken = balanceOfVToken * exchangeRate / 1e18;
        console.log("balanceOfVToken after mul with exchange rate: ", balanceOfVToken);
        return balanceOfVToken;
    }

    function _underlyingDecimals(address underlying) internal view returns (uint) {
        return IBEP20(underlying).decimals();
    }

    function _vTokenDecimals(address vToken) internal view returns (uint) {
        return VTokenInterface(vToken).decimals();
    }

    function _getExchangeRate(address vToken) internal view returns (uint256) {
        return VTokenInterface(vToken).exchangeRateStored();
    }

    function _supplyRatePerBlock(address vToken) internal view returns (uint256) {
        return VTokenInterface(vToken).supplyRatePerBlock();
    }
}


contract StrategyVenus is StrategyStorageVenus, IStrategy {

    address internal _want;
    address internal _vToken;

    function want() external override view returns (address) {
        return _want;
    }

    function deposit() external override {
        uint256 balanceOfUnderlying = _balanceOfUnderlying(_want);
        if (balanceOfUnderlying > 0) {
            _deposit(_want, _vToken, balanceOfUnderlying);
        }
    }

    function withdraw(uint256 amount) external override {
        _redeem(_vToken, amount);
        _sendToVaultWithFee(_want, amount);
    }

    function withdrawAll() external override returns (uint256) {
        uint256 balanceOfVToken = _balanceOfVToken(_vToken);
        if (balanceOfVToken > 0) {
            _redeem(_vToken, balanceOfVToken);
        }

        uint256 balanceOfUnderlying = _balanceOfUnderlying(_want);
        _sendToVault(_want, balanceOfUnderlying);
        return balanceOfUnderlying;
    }

    function balanceOf() external override view returns (uint256) {
        console.log("balance in strategy: ", _balanceOfUnderlying(_want) + _balanceOfVTokenInUnderlying(_vToken));
        return _balanceOfUnderlying(_want) + _balanceOfVTokenInUnderlying(_vToken);
    }

    function withdrawalFee() external override view returns (uint256) {
        return _withdrawalFee;
    }
    
    function supplyRatePerBlock() external override view returns (uint256) {
        return _supplyRatePerBlock(_vToken);
    }
}

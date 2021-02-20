//SPDX-License-Identifier: MIT
pragma solidity ^0.7.4;

import "./StrategyStorage.sol";
import "../interfaces/IBEP20.sol";
import "../interfaces/IVToken.sol";

contract StrategyVenus is StrategyStorage {

    function _deposit(address underlying, address vToken, uint256 _amount) internal {
        IBEP20(underlying).approve(vToken, 0);
        IBEP20(underlying).approve(vToken, _amount);
        VBep20Interface(vToken).mint(_amount);
    }

    function _redeem(address vToken, uint256 amount) internal {
        return VBep20Interface(vToken).redeem(amount);
    }

    function _balanceOfVToken(address vToken) internal view returns (uint) {
        return VTokenInterface(vToken).balanceOf(address(this));
    }

    function _balanceOfVTokenInUnderlying(address vToken) internal view returns (uint) {
        uint256 balanceOfVToken = _balanceOfVToken(vToken);
        if (balanceOfVToken > 0) {
            balanceOfVToken = balanceOfVToken * _getExchangeRate(vToken) / 1e18;
        }
        return balanceOfVToken;
    }

    function _underlyingDecimals(address underlying) internal view returns (uint) {
        return IBEP20(underlying).decimals();
    }

    function _vTokenDecimals(address vToken) internal view returns (uint) {
        return VTokenInterface(vToken).decimals();
    }
    function _underlyingDecimals(address underlying) internal view returns (uint) {
        return IBEP20(underlying).decimals();
    }
    
    function _getExchangeRate(address vToken) internal view returns (uint) {
        return VTokenInterface(vToken).exchangeRateStored();
    }

    function _getApy() internal view returns (uint256) {
        return 0;
    }

}

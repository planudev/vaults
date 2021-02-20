//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./StrategyStorage.sol";
import "../interfaces/IBEP20.sol";
import "../interfaces/IVToken.sol";
// import "../interfaces/IStrategy.sol";

// contract StrategyVenus is StrategyStorage, IStrategy {
contract StrategyVenus is StrategyStorage {

    // function want() external view returns (address);

    // function deposit() external;

    // function withdraw(uint256) external;

    // function withdrawAll() external returns (uint256);

    // function balanceOf() external view returns (uint256);

    // function withdrawalFee() external view returns (uint256);
    
    // function annualPercentageYield() external view returns (uint256);
    
    function _deposit(address underlying, address vToken, uint256 _amount) internal {
        IBEP20(underlying).approve(vToken, 0);
        IBEP20(underlying).approve(vToken, _amount);
        VBep20Interface(vToken).mint(_amount);
    }

    function _redeem(address vToken, uint256 amount) internal returns (uint) {
        return VBep20Interface(vToken).redeem(amount);
    }

    function _balanceOfVToken(address vToken) internal view returns (uint) {
        return VTokenInterface(vToken).balanceOf(address(this));
    }

    function _balanceOfVTokenInUnderlying(address vToken) internal view returns (uint) {
        uint256 balanceOfVToken = _balanceOfVToken(vToken);
        if (balanceOfVToken > 0)
            balanceOfVToken = balanceOfVToken * _getExchangeRate(vToken) / 1e18;
        return balanceOfVToken;
    }

    function _underlyingDecimals(address underlying) internal view returns (uint) {
        return IBEP20(underlying).decimals();
    }

    function _vTokenDecimals(address vToken) internal view returns (uint) {
        return VTokenInterface(vToken).decimals();
    }

    function _getExchangeRate(address vToken) internal view returns (uint) {
        return VTokenInterface(vToken).exchangeRateStored();
    }

    function _getApy() internal view returns (uint256) {
        return 0;
    }
}

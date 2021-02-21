//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./StrategyStorage.sol";
import "../interfaces/IBEP20.sol";
import "../interfaces/IFToken.sol";
import "../interfaces/IStrategy.sol";

contract StrategyStorageForTube is StrategyStorage {
    
    function _deposit(address underlying, address vToken, uint256 _amount) internal {
    }

    function _redeem(address vToken, uint256 amount) internal returns (uint) {
        return 0;
    }

    function _balanceOfUnderlying(address underlying) internal view returns (uint256) {
        return IBEP20(underlying).balanceOf(address(this));
    }

    function _balanceOfVToken(address vToken) internal view returns (uint256) {
        return 0;
    }

    function _balanceOfVTokenInUnderlying(address vToken) internal view returns (uint256) {
        return 0;
    }

    function _underlyingDecimals(address underlying) internal view returns (uint) {
        return 0;
    }

    function _vTokenDecimals(address vToken) internal view returns (uint) {
        return 0;
    }

    function _getExchangeRate(address vToken) internal view returns (uint256) {
        return 0;
    }

    function _getApy() internal pure returns (uint256) {
        // [TODO] #2: calculate to get APY in ForTube. 
        return 0;
    }
}


contract StrategyForTube is StrategyStorageForTube, IStrategy {

    address internal _want;
    address internal _vToken;

    function want() external override view returns (address) {
        return _want;
    }

    function deposit() external override {
    }

    function withdraw(uint256 amount) external override {
    }

    function withdrawAll() external override returns (uint256) {
        return 0;
    }

    function balanceOf() external override view returns (uint256) {
        return 0;
    }

    function withdrawalFee() external override view returns (uint256) {
        return 0;
    }
    
    function annualPercentageYield() external override pure returns (uint256) {
        return 0;
    }
}

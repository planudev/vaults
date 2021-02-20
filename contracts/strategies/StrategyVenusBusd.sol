//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./StrategyVenus.sol";
import "../interfaces/IStrategy.sol";

contract StrategyVenusBusd is StrategyVenus, IStrategy {

    // 0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56
    address private _want = address(0x8301F2213c0eeD49a7E28Ae4c3e91722919B8B47);
    // 0x95c78222B3D6e262426483D42CfA53685A67Ab9D
    address private _vTokenAddress = address(0x08e0A5575De71037aE36AbfAfb516595fE68e5e4);

    constructor(address _controller) {
        controller = _controller;
    }

    function want() external override view returns (address) {
        return _want;
    }

    function deposit() external override {
        _deposit(_want, _vTokenAddress, _balanceOfUnderlying(_want));
    }

    function withdraw(uint256 amount) external override {
        _redeem(_vTokenAddress, amount);
        _sendToVaultWithFee(_want, amount);
    }

    function withdrawAll() external override returns (uint256) {
        uint256 balanceOfVToken = _balanceOfVToken(_vTokenAddress);
        _redeem(_vTokenAddress, balanceOfVToken);

        uint256 balanceOfBusd = _balanceOfUnderlying(_want);
        _sendToVault(_want, balanceOfBusd);
        return balanceOfBusd;
    }

    function balanceOf() external override view returns (uint256) {
        return _balanceOfUnderlying(_want) + _balanceOfVTokenInUnderlying(_vTokenAddress);
    }

    function withdrawalFee() external override view returns (uint256) {
        return _withdrawalFee;
    }
    
    function annualPercentageYield() external override view returns (uint256) {
        return _getApy();
    }
}

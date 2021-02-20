//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./StrategyVenus.sol";

contract StrategyVenusBusd is StrategyVenus {
    constructor(address _controller) {
        _want = address(0x8301F2213c0eeD49a7E28Ae4c3e91722919B8B47);    // main: 0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56
        _vToken = address(0x08e0A5575De71037aE36AbfAfb516595fE68e5e4);   // main: 0x95c78222B3D6e262426483D42CfA53685A67Ab9D
        
        controller = _controller;
    }
}

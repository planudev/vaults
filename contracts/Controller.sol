//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./interfaces/IStrategy.sol";
import "./interfaces/IERC20.sol";
import "./libraries/SafeERC20.sol";
import "./libraries/Address.sol";
import "./libraries/EnumerableSet.sol";

contract Controller {
    using SafeERC20 for IERC20;
    using Address for address;
    using EnumerableSet for EnumerableSet.AddressSet;

    address public strategist;
    address public rewards;

    // mapping between (token, vault)
    mapping (address => address) public vaults;

    // active strategy on certain token (token, strategy)
    mapping (address => address) public strategies;

    // token -> strategy[]
    mapping (address => EnumerableSet.AddressSet) availableStrategies;

    constructor() {
        strategist = msg.sender;
        rewards = address(this);
    }

    function setVault(address _token, address _vault) public {
        require(msg.sender == strategist, "!strategist");
        require(vaults[_token] == address(0), "vault for this token already deployed");

        vaults[_token] = _vault;
    }

    function setStrategy(address _token, address _strategy) public {
        require(msg.sender == strategist, "!strategist");

        address current = strategies[_token];
        if (current != address(0)) {
            IStrategy(current).withdrawAll();
        }

        strategies[_token] = _strategy;
        addStrategy(_token, _strategy);
    }

    function addStrategy(address _token, address _strategy) public {
        require(msg.sender == strategist, "!strategist");
        require(_strategy.isContract(), "Strategy is not a contract");
        require(!availableStrategies[_token].contains(_strategy), "Strategy already exists");

        availableStrategies[_token].add(_strategy);
    }

    function balanceOf(address _token) external view returns (uint256) {
        return IStrategy(strategies[_token]).balanceOf();
    }

    function withdraw(address _token, uint256 _amount) external {
        require(msg.sender == vaults[_token], "!vault");
        IStrategy(strategies[_token]).withdraw(_amount);
    }

    function earn(address _token, uint256 _amount) public {
        address _strategy = strategies[_token];
        address _want = IStrategy(_strategy).want();
        require(_want == _token, "!want");
        IERC20(_token).safeTransfer(_strategy, _amount);
        IStrategy(_strategy).deposit();
    }

    function getBestStrategy(address _token) internal view returns (address bestStrategy) {
        bestStrategy = address(0);
        uint maxApy = 0;
        for (uint i = 0; i < availableStrategies[_token].length(); i++) {
            if (bestStrategy == address(0)) {
                bestStrategy = availableStrategies[_token].at(i);
                maxApy = IStrategy(availableStrategies[_token].at(i)).supplyRatePerBlock();
            }

            uint256 apy = IStrategy(availableStrategies[_token].at(i)).supplyRatePerBlock();
            if (maxApy < apy) {
                bestStrategy = availableStrategies[_token].at(i);
                maxApy = apy;
            }
        }

        return bestStrategy;
    }

    function invest(address _token, uint256 _amount) external {
        address currentStrategy = strategies[_token];
        address bestStrategy = getBestStrategy(_token);

        // if (currentStrategy == bestStrategy) {
        //     return;
        // }

        currentStrategy = bestStrategy;
        IERC20(_token).safeTransfer(currentStrategy, _amount);
        IStrategy(bestStrategy).deposit();
    }
}



/*

StrategyVenusBUSD.sol    -|                          |
StrategyVenusUSDC.sol     |--- StrategyVenus    -----|
StrategyVenusUSDT.sol    -|                          |
...                                                  |
StrategyForTubeBUSD.sol  -|                          |
StrategyForTubeUSDC.sol   |--- StrategyForTube  -----|-------- IStrategy
StrategyForTubeUSDT.sol  -|                          |
....                                                 |
StrategyCreamBUSD.sol    -|                          |
StrategyCreamUSDC.sol     |--- StrategyCream    -----|
StrategyCreamUSDT.sol    -|
....


*/
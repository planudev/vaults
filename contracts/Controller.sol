//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./interfaces/IStrategy.sol";
import "./interfaces/IERC20.sol";
import "./libraries/SafeERC20.sol";

enum LendingProtocol {
    Cream,
    ForTube,
    Venus
}

contract Controller {
    using SafeERC20 for IERC20;

    address public cream;
    address public forTube;
    address public venus;

    address public strategist;

    // mapping between (token, vault)
    mapping (address => address) vaults;

    // active strategy on certain token (token, strategy)
    mapping (address => address) strategies;

    constructor(address _cream, address _forTube, address _venus) {
        cream = _cream;
        forTube = _forTube;
        venus = _venus;

        strategist = msg.sender;
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
    }

    // Transfers the profits earned from the yield generating activities of the Strategy to the Vault. Takes an address of a token to withdraw and an amount.
    function earn(address _token, uint256 _amount) external {
        address currentStrategy = strategies[_token];
        address want = IStrategy(currentStrategy).want();
        if (want != _token) {
            revert();
        } else {
            IERC20(_token).safeTransfer(currentStrategy, _amount);
        }

        IStrategy(currentStrategy).deposit();
    }

    function compareAPY() internal view returns (LendingProtocol) {

    }
}
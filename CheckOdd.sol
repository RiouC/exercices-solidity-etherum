// SPDX-License-Identifier: GPL-3.0

pragma solidity  ^0.8.0;

/**
 * @title CheckOdd
 * @dev Implements a function checking if a number passed as parameter is odd
 */
contract CheckOdd {
    function check(uint256 number) public pure returns (bool) {
        return number % 2 == 1;
    }
}

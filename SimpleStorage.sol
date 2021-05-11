// SPDX-License-Identifier: GPL-3.0

pragma solidity  ^0.8.0;

/**
 * @title SimpleStorage
 * @dev Implements a simple storage
 */
contract SimpleStorage {
    uint256 private _storedData;

    function storedData() public view returns (uint256) {
        return _storedData;
    }

    function setStoredData(uint256 value) public {
        _storedData = value;
    }
}

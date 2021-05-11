// SPDX-License-Identifier: MIT

pragma solidity  ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/Address.sol";

/** 
 * @title PayableCalculator
 * @dev Implements basic arithmetic operations (add, sub, mul, div, mod)
 */
contract PayableCalculator {
    using Address for address payable;
    
    address private _owner;
    uint256 private _profit;
    uint256 private _arithmeticCounter;
    
    event Added(address indexed sender, int256 a, int256 b, int256 res);
    event Subbed(address indexed sender, int256 a, int256 b, int256 res);
    event Multiplied(address indexed sender, int256 a, int256 b, int256 res);
    event Divided(address indexed sender, int256 a, int256 b, int256 res);
    event Moduled(address indexed sender, int256 a, int256 b, int256 res);
    
    constructor(address owner_) {
        _owner = owner_;
    }
    
    // Function declarations below
    receive() external payable {
        _deposit(msg.value);
    }

    fallback() external {
    }
    
    function _deposit(uint256 amount) private {
        _profit += amount;
    }
    
    function withdraw() public {
        require(msg.sender == _owner, "PayableCalculator (withdraw): Only owner can withdraw funds");
        require(_profit > 0, "PayableCalculator (withdraw): can not withdraw 0 ether");
        uint256 amount = _profit;
        _profit = 0;
        payable(msg.sender).sendValue(amount);
    }

    function add(int256 a, int256 b) public payable finneySent receivedFinney incrArithCounter returns(int256) {
        int256 res = a + b;
        emit Added(msg.sender, a, b, res);
        return res;
    }
    
    function sub(int256 a, int256 b) public payable finneySent receivedFinney incrArithCounter returns(int256) {
        int256 res = a - b;
        emit Subbed(msg.sender, a, b, res);
        return res;
    }
  
    function mul(int256 a, int256 b) public payable finneySent receivedFinney incrArithCounter returns(int256) {
	int256 res = a * b;
	emit Multiplied(msg.sender, a, b, res);
	return res;
    }
  
    function div(int256 a, int256 b) public payable finneySent incrArithCounter returns(int256) {
	require(b != 0, "Calculator: cannot divide by zero");
	_deposit(1000000 gwei);
	int256 res = a / b;
	emit Divided(msg.sender, a, b, res);
	return res;
    }
  
    function mod(int256 a, int256 b) public payable finneySent receivedFinney incrArithCounter returns(int256) {
	int256 res = a % b;
	emit Moduled(msg.sender, a, b, res);
	return res;
    }
  
    function profit() public view returns (uint256) {
	return _profit;
    }
  
    function arithmeticCounter() public view returns (uint256) {
	return _arithmeticCounter;
    }
  
    modifier finneySent() {
	require(msg.value == 1000000 gwei, "PayableCalculator need 1 finney to do your computation");
	_;
    }
  
    modifier receivedFinney() {
	_deposit(1000000 gwei);
	_;
    }
  
    modifier incrArithCounter() {
	_arithmeticCounter++;
	_;
    }
}

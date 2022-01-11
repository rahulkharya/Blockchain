// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.4.22 <0.7.0;

contract Value {

    uint256 public tokenBalance;

    constructor() public {
    
        tokenBalance = 0;
    
    }

    function addValue() payable public {
    
        tokenBalance = tokenBalance + (msg.value/10);
    
    }

    function getTokenBalance() public view returns(uint256) {

        return tokenBalance;

    }

}

// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.4.0;

contract FallbackFunctionRK {

    // declaring the state variable
    uint x;

    // mapping addresses to their balances
    mapping(address => uint) balance;

    // creating a constructor
    constructor() public {
    
        x = 10;
    
    }


    // creating a function
    function setX(uint _x) public returns (bool) {
    
        x = _x;
    
    }


    // this fallback function will keep all the ether
    function() public payable {
    
        balance[msg.sender] += msg.value;
    
    }

}


// creating the sender contract
contract SenderRK {

    function transfer() public payable {
    
        address _reciever = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;

        _reciever.transfer(20);
    
    }

}

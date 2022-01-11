// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.4.22 <0.7.0;

contract eventExample {

    // declaring state variable
    uint256 public value = 0;

    // declaring an event
    event Increment(address owner);

    // logging event in a function
    function getValue(uint _a, uint _b) public {
    
        emit Increment(msg.sender);

        value = _a + _b;
    
    }

}

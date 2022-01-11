// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.4.22 <0.7.0;

contract Sender {

    address private owner;

    constructor() public {
        owner = msg.sender;
    }

    function updateOwner(address newOwner) public {

        require(msg.sender == owner, 'only current owner can update owner');
        owner = newOwner;

    }

    function getOwner() public view returns (address) {
    
        return owner;

    }

}

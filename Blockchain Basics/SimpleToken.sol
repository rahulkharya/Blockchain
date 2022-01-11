pragma solidity ^0.4.24;

contract SimpleToken {

    address owner;
    mapping(address => uint256) public accounts;

    constructor(uint256 initialSupply) public {

        owner = msg.sender;
        accounts[owner] = initialSupply;

    }

    function transfer(address to, uint256 value) public {
    
        require(accounts[msg.sender] >= value);
        require(accounts[to] + value >= accounts[to]);

        accounts[msg.sender] -= value;
        accounts[to] += value;

    }

}

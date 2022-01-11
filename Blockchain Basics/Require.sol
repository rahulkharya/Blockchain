pragma solidity ^0.5.0;

contract Bank {

    mapping(address => uint) public accounts;

    function deposit() payable public {

        require(accounts[msg.sender] + msg.value >= accounts[msg.sender], 'Overflow error');
        accounts[msg.sender] += msg.value;

    }

    function withdraw(uint money) public {

        require(money <= accounts[msg.sender]);
        accounts[msg.sender] -= money;

    }

}

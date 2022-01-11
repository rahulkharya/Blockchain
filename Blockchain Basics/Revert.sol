pragma solidity ^0.5.0;

contract Bank {

    mapping(address => uint) public accounts;

    function deposit() public payable {

        if(accounts[msg.sender] + msg.value >= accounts[msg.sender]) {
            revert('Stack Overflow');
        }

        accounts[msg.sender] += msg.value;

    }

    function withdraw(uint money) public {
    
        if(accounts[msg.sender] < money) {
            revert();
        }

        accounts[msg.sender] -= money;
    
    }

}

// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.4.22 <0.7.0;

contract donations {

    struct Donation {

        uint id;
        uint amount;
        string donor;
        string message;
        uint timestamp;     // in seconds since Unix start

    }

    uint amount = 0;
    uint id = 0;
    mapping(address => uint) public balances;
    mapping(address => Donation[]) public donationsMap;

    function donate(address _recipient, string memory _donor, string memory _msg) public payable {

        require(msg.value > 0, "Minimum amount to be deposited is 1");

        amount = msg.value;

        balances[_recipient] += amount;

        donationsMap[_recipient].push(Donation(id++, amount, _donor, _msg, block.timestamp));

    }

    function withdraw() public {
    
        amount = balances[msg.sender];

        balances[msg.sender] -= amount;

        require(amount > 0, "amount should be greater than 0");

        (bool success, ) = msg.sender.call{ value : amount }("");

        if(!success) {

            revert();

        }
    
    }

    function balances_getter(address _recipient) public view returns(uint) {
    
        return balances[_recipient];
    
    }

    function getBalance() public view returns(uint) {

        return msg.sender.balance;

    }

}

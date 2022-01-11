// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Lottery {


    // declaring variables
    address public manager;
    address payable[] public participants;


    // defining manager will be handeling main address
    constructor() {

        manager = msg.sender;   // global variable

    }


    // receiving ether from participant - this will be one time only executable function
    receive() external payable {

        // checking that participant should transfer 2 ether
        require(msg.value == 2 ether);

        // registering participant's address
        participants.push(payable(msg.sender));

    }

    // returning balance of current participant
    function getBalance() public view returns(uint) {

        // verifying that only manager should be able to view balances
        // checking address should be equal to manager's address
        require(msg.sender == manager);

        return address(this).balance;
    
    }

    // generating random sha256 values
    function random() public view returns(uint) {

        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, participants.length)));

    }

    // selecting a winner from the participants
    function selectWinner() public {

        // making sure manager is selecting the winner
        require(msg.sender == manager);

        // setting minimum number of participants
        require(participants.length >= 3);

        // storing the output of random function
        uint r = random();

        address payable winner;

        // retreiving random index from participants array
        uint index = r % participants.length;

        // assigning retreived participant's index and declaring it as winner
        winner = participants[index];
        
        // transferring balance to the winner
        winner.transfer(getBalance());

        // reseting game (participants dynamic array)
        participants = new address payable[](0);
        
        }

}

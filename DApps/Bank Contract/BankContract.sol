// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.6;

contract BankContract {

    struct client_account {

        int client_id;
        address client_address;
        uint client_balance_in_eth;

    }

    client_account[] clients;

    int clientCounter;

    address payable manager;
    mapping(address => uint) public interestDate;

    constructor() public {
        clientCounter = 0;
    }

    modifier onlyManager() {

        require(msg.sender == manager, 'Only manager can call');
        _;

    }

    modifier onlyClient() {

        bool isClient = false;

        for(uint i = 0; i < clients.length; i++) {
            if(clients[i].client_address == msg.sender) {
                isClient = true;
                break;
            }
        }

        require(isClient, 'Only client can call');
        _;

    }

    receive() external payable { }

    function setManager(address managerAddress) public returns(string memory) {

        manager = payable(managerAddress);
        return '';

    }

    function joinAsClient() public payable returns(string memory) {

        interestDate[msg.sender] = now;

        clients.push(client_account(
            clientCounter++,
            msg.sender,
            address(msg.sender).balance
        ));

        return "";

    }

    function deposit() public payable onlyClient {

        payable(address(this)).transfer(msg.value);

    }

    function withdraw(uint amount) public payable onlyClient {

        msg.sender.transfer(amount * 1 ether);

    }

    function sendInterest() payable public onlyManager {

        for(uint i = 0; i < clients.length; i++) {

            address initialAddress = clients[i].client_address;
            uint lastInterestDate = interestDate[initialAddress];

            if(now < lastInterestDate + 10 seconds) {
                revert("It's been less than 10 seconds");
            }

            payable(initialAddress).transfer(1 ether);
            interestDate[initialAddress] = now;

        }

    }

        function getContractBalance() public view returns(uint) {
            return address(this).balance;
        }

}

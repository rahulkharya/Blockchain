// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract CrowdFunding {

    mapping(address => uint) public contributors;
    address public manager;
    uint public minimumContribution;
    uint public deadline;
    uint public target;
    uint public raisedAmount;
    uint public noOfContributors;

    struct Request {
    
        string description;
        address payable recipient;
        uint value;
        bool completed;
        uint noOfVoters;
        mapping(address => bool) voters;
    
    }

    mapping(uint => Request) public requests;
    uint public numRequests;

    constructor(uint _target, uint _deadline) {

        target = _target;
        deadline = block.timestamp + _deadline;
        minimumContribution = 100 wei;
        manager = msg.sender;

    }

    function sendEth() public payable {
    
        // checking deadline
        require(block.timestamp < deadline, "Deadline has reached");

        // checking minimum contribution
        require(msg.value >= minimumContribution, "Minimum contribution should be 100 wei");

        // checking contributor's donation (single or multiple donations)
        if(contributors[msg.sender] == 0) {
        
            noOfContributors++;
        
        }

        contributors[msg.sender] += msg.value;
        
        raisedAmount += msg.value;
    
    }

    // getting contract balance
    function getContractBalance() public view returns(uint) {
    
        return address(this).balance;
    
    }

    // refunding to users when criteria is not met
    function refund() public {

        // verifying whether conditions are met
        require(block.timestamp > deadline && raisedAmount < target, "You are not eligible for refund");

        // checking contributor's contribution should be greater than 0
        require(contributors[msg.sender] > 0);

        // making the contributor payable
        address payable user = payable(msg.sender);

        // refunding the amount to the user
        user.transfer(contributors[msg.sender]);
        contributors[msg.sender] = 0;        

    }

    modifier onlyManager() {

        require(msg.sender == manager, "Only manager can call this function");
        _;
    }

    function createRequests(string memory _description, address payable _recipient, uint _value) public onlyManager {
    
        Request storage newRequest = requests[numRequests];
        numRequests++;

        newRequest.description = _description;
        newRequest.recipient = _recipient;
        newRequest.value = _value;
        newRequest.completed = false;
        newRequest.noOfVoters = 0;

    }

    function voteRequest(uint _requestNo) public {
    
        // validating contributor
        require(contributors[msg.sender] > 0, "You must be a contributor");
        Request storage thisRequest = requests[_requestNo];

        // checking if a contributor has already voted
        require(thisRequest.voters[msg.sender] == false, "You have already voted");
        thisRequest.voters[msg.sender] = true;
        thisRequest.noOfVoters++;
    
    }

    function makePayment(uint _requestNo) public onlyManager {
    
        // checking required amount is raised
        require(raisedAmount >= target);
        Request storage thisRequest = requests[_requestNo];

        // checking whether the request is already completed
        require(thisRequest.completed = false, "This request has already been completed");

        // checking the majority in voting
        require(thisRequest.noOfVoters > noOfContributors / 2, "Majority contributors does not support");

        thisRequest.recipient.transfer(thisRequest.value);

        thisRequest.completed = true;

    
    }

}

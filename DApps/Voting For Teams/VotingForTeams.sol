// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.5.11;

// demonstrating DAPPS

// contract for voting
contract VotingForTopper {

    
    // refer to the owner
    address owner;

    
    // declaring variable 'purpose' to demonstrate the purpose of voting
    string public purpose;


    // defining the structure with boolen variables authorized and voted
    struct Voter {

        bool authorized;
        bool voted;

    }


    // declaring state variables
    uint totalVotes;
    uint teamA;
    uint teamB;
    uint teamC;


    // mapping voter info
    mapping(address => Voter) info;


    // defining purpose of voting within constructor
    constructor(string memory _name) public {

        purpose = _name;
        owner = msg.sender;

    }


    // defining a modifier to verify the ownership
    modifier ownerOn() {

        require(msg.sender == owner);
        _;

    }


    // verifying whether a person has already voted
    function authorize(address _person) ownerOn public {

        info[_person].authorized = true;

    }


    // verifying and skipping if a person has already voted
    // else allow voting and calculate total votes for team A
    function teamA_Calc(address _address) public {
    
        require(!info[_address].voted, "You have already voted");

        require(info[_address].authorized, "You are not authorized to vote");

        info[_address].voted = true;

        teamA++;
        totalVotes++;
        
    }


    // verifying the same for team B
    function teamB_Calc(address _address) public {
    
        require(!info[_address].voted, "You have already voted");

        require(info[_address].authorized, "You are not authorized to vote");

        info[_address].voted = true;

        teamB++;
        totalVotes++;
    
    }


    // verifying the same for team C
    function teamC_Calc(address _address) public returns (string memory) {

        require(!info[_address].voted, "You have already voted");

        require(info[_address].authorized, "You are not authorized to vote");

        info[_address].voted = true;

        teamC++;
        totalVotes++;

        return ("Thank you for voting");

    }


    function totalVotesCalc() public view returns (uint) {

        return totalVotes;

    }


    function votingResult() public view returns (string memory) {
    
        if(teamA > teamB) {

            if(teamA > teamC) {
            
                return "Winner: Team A";
            
            }

            else if(teamC > teamA) {

                return "Winner: Team C";

            }
        
        else if(teamB > teamC) {
            
            return "Winner: Team B";
        
        }

        else if(teamA == teamB && teamA == teamC || teamB == teamC) {
        
            return "It's a tie!";
        
        }

        }
    
    }

}

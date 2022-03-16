// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// importing files and libraries
import './Owned.sol';
import './Logger.sol';
import './IFaucet.sol';

// contract
contract Faucet is Owned, Logger, IFaucet {

    uint public numOfFunders;
    mapping(address => bool) private funders;
    mapping(uint => address) private lutFunders;

    // modifiers
    modifier limitWithdraw(uint withdrawAmount) {
        
        require(
            withdrawAmount <= 1000000000000000000,
            "Cannot withdraw more than 1 ether"
        );
        _;   
    }

    // function: receive
    receive() external payable {}

    // function: implementing Logger function emitLog
    function emitLog() pure override public returns (bytes32) {
        return "Namaste";
    }

    
    // function: adding funds and funder to funders mapping, setting it to true
    //           also checking and preventing duplication of funders
    function addFunds() override external payable {

        address funder = msg.sender;

        if(!funders[funder]) {
            funders[funder] = true;
            lutFunders[numOfFunders] = funder;
            numOfFunders++;
        }
    }

    // function: retreiving all funders
    function getAllFunders() external view returns(address[] memory) {
        
        address[] memory _funders = new address[](numOfFunders);

        for(uint i = 0; i < numOfFunders; i++) {
            _funders[i] = lutFunders[i];
        }

        return _funders;
    }

    // function: retreiving funder by index
    function getFunderByIndex(uint8 index) external view returns(address) {
       
        return lutFunders[index];    
    }

    // function: withdrawing from account
    function withdraw(uint withdrawAmount) override external limitWithdraw(withdrawAmount) {
      
        payable(msg.sender).transfer(withdrawAmount);    
    }


    // function: transfer ownership
    function transferOwnership(address newOwner) external onlyOwner {

        owner = newOwner;
    }

}
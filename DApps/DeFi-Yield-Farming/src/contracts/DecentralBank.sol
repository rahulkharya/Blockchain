// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import './RWD.sol';
import './Tether.sol';

contract DecentralBank {

    string public name = 'Decentral Bank';
    address public owner;
    Tether public tether;
    RWD public rwd;

    // list of stakers
    address[] public stakers;

    mapping(address => uint) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;

    constructor(Tether _tether, RWD _rwd) {
        tether = _tether;
        rwd = _rwd;
        owner = msg.sender;
    }

    
    // staking function
    function depositTokens(uint _amount) public {

        require(_amount > 0, "Invalid amount! Minimum staking amount is 1 USDT");

        // transfer tether tokens to this contract address for staking
        tether.transferFrom(msg.sender, address(this), _amount);

        // update staking balance
        stakingBalance[msg.sender] += _amount;

        if(!hasStaked[msg.sender]) {
            stakers.push(msg.sender);
        }

        // update staking balance
        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;

    }


    // function: unstaking tokens
    function unstakeTokens() public {

        uint balance = stakingBalance[msg.sender];

        // require the amount to be greater than zero
        require(balance > 0, 'staking balance should be greater than zero');

        // transfer the tokens to the specified contract address from our bank
        tether.transfer(msg.sender, balance);

        // reset staking balance
        stakingBalance[msg.sender] = 0;

        // update staking status
        isStaking[msg.sender] = false;

    }


    // function: issuing tokens to the staked customers
    function issueTokens() public {

        require(msg.sender == owner, 'only owner can issue reward tokens');

        // fetching stakers and assigning them rewards
        for(uint i=0; i < stakers.length; i++) {

            address recipient = stakers[i];
            uint balance = stakingBalance[recipient] / 9;

            if(balance > 0) {
                rwd.transfer(recipient, balance);
            }

        }

    }

}
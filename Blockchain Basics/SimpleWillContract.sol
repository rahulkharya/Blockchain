// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.5.7;

contract Will {

    address owner;
    uint256 fortune;
    bool deceased;

    constructor() payable public {
        owner = msg.sender;
        fortune = msg.value;
        deceased = false;
    }

    // modifier - checking that only owner can do the transaction
    modifier onlyOwner {
        require(msg.sender == owner, "Only owner can do the transaction");
        _;
    }

    // modifier - checking that only deceased person is allowed to write a will
    modifier mustBeDeceased {
        require(deceased == true, "Only deceased person can write his will");
        _;
    }

    // list of family wallets
    address payable[] familyWallets;

    // mapping through inheritence
    mapping(address => uint256) inheritance;

    // set inheritance for each address
    function setInheritance(address payable wallet, uint256 amount) public onlyOwner {
        familyWallets.push(wallet);
        inheritance[wallet] = amount;

    }

    // pay each family member based on their wallet address
    function payout() private mustBeDeceased {
        for(uint i = 0; i < familyWallets.length; i++) {
            // transferring the funds from contract address to receiver address
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
        }
    }

    function hasDeceased() public onlyOwner {
        deceased = true;
        payout();
    }
}

// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.4.22 <0.7.0;

import "remix_tests.sol";
import "remix_accounts.sol";
import './Donations.sol';

contract testSuite is donations {

    address acc0 = TestsAccounts.getAccount(0);     // owner by default
    address acc1 = TestsAccounts.getAccount(1);
    address acc2 = TestsAccounts.getAccount(2);
    address acc3 = TestsAccounts.getAccount(3);

    address recipient = TestsAccounts.getAccount(4);    // recipient

    // #value: 1000000000000000000
    // #sender: account-1
    function donateAcc1AndCheckBalance() public payable {

        Assert.equal(msg.value, 1000000000000000000, "value should be 1 ether");
        
        donate(recipient, "Mario", "This is Mario from Nintendo");

        Assert.equal(balances_getter(recipient), 1000000000000000000, "balances should be 1 ether");

    }

    // #value: 1000000000000000000
    // #sender: account-2
    function donateAcc2AndCheckBalance() public payable {
    
        Assert.equal(msg.value, 1000000000000000000, "value should be 1 ether");

        donate(recipient, "Naruto", "I am Naruto Uzumaki");

        Assert.equal(balances_getter(recipient), 2000000000000000000, "balances should be 2 ether");
    
    }

    // #value: 1000000000000000000
    // #sender: account-3
    function donateAcc3AndCheckBalance() public payable {

        Assert.equal(msg.value, 2000000000000000000, "value should be 2 ether");

        donate(recipient, "Itachi", "My name is Itachi Uchiha");

        Assert.equal(balances_getter(recipient), 4000000000000000000, "balances should be 4 ether");

    }

    // sender: account-4
    function withdrawDonations() public payable {

        uint initialBalance = getBalance();

        withdraw();

        uint finalBalance = getBalance();

        Assert.equal(finalBalance - initialBalance, 4000000000000000000, "balances should be 4 ether");

    }

}

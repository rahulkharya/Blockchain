// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.4.22 <0.7.0;

// 

import "remix_tests.sol";
import "remix_accounts.sol";
import "./Sender.sol";

// inherit sender contract
contract SenderTest is Sender {

    // defining variables referring to different accounts
    address acc0;
    address acc1;
    address acc2;

    // initiating account variables
    function beforeAll() public {

        acc0 = TestsAccounts.getAccount(0);
        acc1 = TestsAccounts.getAccount(1);
        acc2 = TestsAccounts.getAccount(2);

    }

    // testing whether initial owner is set correctly
    function testInitialOwner() public {

        Assert.equal(getOwner(), acc0, "Owner should be acc0");

    }

    // updating owner for the first time
    function updateOwnerOnce() public {

        // checking the message caller is as expected
        Assert.ok(msg.sender == acc0, "caller should be the default account i.e. acc0");

        // update owner address to acc1
        updateOwner(acc1);

        // checking whether owner is updated to expected account
        Assert.equal(getOwner(), acc1, "owner should be updated to acc1");

    }

    // updating owner once again
    function updateOwnerOnceAgain() public {

        // checking whether the caller is custom and as expected
        Assert.ok(msg.sender == acc1, "caller should be the updated account i.e. acc1");

        // update owner address to acc2
        updateOwner(acc2);

        // checking whether owner is updated to expected account
        Assert.equal(getOwner(), acc2, "owner should be updated to acc2");

    }

}

// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.4.22 <0.7.0;

import './Value.sol';

contract ValueTest {

    // initializing an instance of Value
    Value v;

    function beforeAll() public {

        // creating an instance of Value
        v = new Value();

    }

    function testInitialBalance() public {

        Assert.equal(v.getTokenBalance(), 0, 'initial token balance should be 0');

    }

    // testing addValue() function /* for solidity version greater than 0.6.1 */
    function addValueOnce() public payable {

        // checking any particular value transferred (in this case 200)
        Assert.equal(msg.value, 200, 'value should be 200');

        // executing addValue()
        v.addValue{ gas: 40000, value: 200 }();

        // checking total balance
        Assert.equal(v.getTokenBalance(), 20, 'token balance should be 20');

    }

}

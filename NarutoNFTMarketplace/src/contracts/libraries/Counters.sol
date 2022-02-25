// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './SafeMath.sol';

library Counters {

    using SafeMath for uint256;

    struct Counter {
        uint256 _value;
    }


    // finding current value of the count
    function current(Counter storage counter) internal view returns(uint256) {

        return counter._value;

    }


    // function that always increments by 1
    function increment(Counter storage counter) internal {

        counter._value += 1;

    }


    // function that always decrements by 1
    function decrement(Counter storage counter) internal {

        counter._value = counter._value.subtract(1);

    }

}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library SafeMath {

    // function add
    function add(uint256 x, uint256 y) internal pure returns(uint256) {
        
        uint256 r = x + y;
        
        require(r >= x, "SafeMath: Addition Overflow");

        return r;

    }


    // function subtract
    function subtract(uint256 a, uint256 b) internal pure returns(uint256) {

        uint256 r = a - b;

        require(b <= a, "SafeMath: Subtraction Overflow");

        return r;

    }


    // function multiply
    function multiply(uint256 a, uint256 b) internal pure returns(uint256) {

        // gas optimization
        if (a == 0) {
            return 0;
        }

        uint256 r = a * b;

        require(r/a == b, "SafeMath: Multiplication Overflow");

        return r;

    }


    // function divide
    function divide(uint256 a, uint256 b) internal pure returns(uint256) {

        uint256 r = a / b;

        require(b > 0, "SafeMath: Division by zero");

        return r;

    }


    // function modulo
    function modulo(uint256 a, uint256 b) internal pure returns(uint256) {

        require(b != 0, "SafeMath: Modulo by zero");

        return a % b;

    }

}
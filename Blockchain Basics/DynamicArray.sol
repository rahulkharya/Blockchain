pragma solidity ^0.5.0;

contract Score {

    uint24[] score;

    function AddScore(uint24 s) public returns(uint24[] memory) {

        score.push(s);
        return score;

    }

    function GetLength() public view returns(uint) {

        return score.length;

    }

    function ClearArray() public returns(uint24[] memory) {
    
        delete score;
        return score;
    
    }
}

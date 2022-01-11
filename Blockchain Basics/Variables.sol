pragma solidity ^0.5.1;

contract VariableExamples {

    bool public switchedOn = true;
    address public owner = msg.sender;
    uint public number = 8;
    bytes32 public awesome1 = 'Solidity is awesome';
    string public awesome2 = 'Solidity is awesome';

    function overflow() public pure returns(uint256) {

        uint256 max = 2 ** 256 - 1;
        return max + 1;

    }

    function underflow() public pure returns(uint256) {

        uint min = 0;
        return min - 1;

    }

}

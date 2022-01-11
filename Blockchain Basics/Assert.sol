pragma solidity ^0.5.0;

contract Math {

    function add(uint a, uint b) internal pure returns (uint) {
    
        uint c = a + b;
        assert(c >= a);
        return c;
    
    }

    function multiply(uint a, uint b) internal pure returns (uint) {

        if(a == 0) {
            return 0;
        }
        
        uint c = a * b;
        assert(c / a == b);
        return c;

    }

}

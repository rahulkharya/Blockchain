pragma solidity ^0.4.24;

contract MemoryStorage {

    uint[20] public arr;

    function StartChange() public {

        FirstChange(arr);
        SecondChange(arr);

    }

    function FirstChange(uint[20] storage x) internal {

        x[0] = 4;

    }

    function SecondChange(uint[20] x) internal pure {
    
        x[0] = 3;
    
    }
}

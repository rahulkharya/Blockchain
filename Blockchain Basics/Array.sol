pragma solidity ^0.5.0;

contract SampleContract {

    uint8[3] nums = [10, 11, 12];

    function getNums() public returns(uint8[3] memory) {

        nums[0] = 20;
        nums[1] = 21;
        nums[2] = 22;

        return nums;

    }

    function getLength() public view returns(uint) {

        return nums.length;

    }

}

// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.4.22 <0.7.0;

contract AttendenceRegister {

    struct Student {

        string name;
        uint class;

    }

    event Added(string name, uint class, uint time);

    mapping(uint => Student) public register;    // rollnumber => student

    function add(uint rollNumber, string memory name, uint class) public returns (uint256) {

        require(class > 0 && class <= 12, "Invalid class");
        require(register[rollNumber].class == 0, "Roll no not available");

        Student memory s = Student(name, class);

        register[rollNumber] = s;
        emit Added(name, class, now);

        return rollNumber;

    }

    function getStudentName(uint rollNumber) public view returns(string memory) {
    
        return register[rollNumber].name;
    
    }

}

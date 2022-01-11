// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.4.22 <0.7.0;

contract mapping_example {

    // defining structure
    struct student {

        string name;
        string subject;
        uint8 marks;

    }

    // creating mapping
    mapping(address => student) result;
    address[] student_result;

    // adding values to the mapping
    function set_student_details() public {
    
        var s = result[0x5B38Da6a701c568545dCfcB03FcB875f56beddC4];

        s.name = "naruto";
        s.subject = "hindi";
        s.marks = 90;

        student_result.push(0x5B38Da6a701c568545dCfcB03FcB875f56beddC4) - 1;
    
    }

    // retrieveing values from mapping
    function get_student_details() view public returns (address[]) {

        return student_result;

    }

    // counting students
    function count_students() view public returns (uint) {
    
        return student_result.length;
    
    }

}

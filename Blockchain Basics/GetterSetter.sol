pragma solidity ^0.5.0;

contract GetterSetter {

    string private message = "Namaste";

    function GetMessage() public view returns(string memory) {

        return message;

    }

    function SetMessage(string memory newMessage) public {

        message = newMessage;

    }

}

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Tether {

    // variables
    string public name = 'Tether Token';
    string public symbol = 'USDT';
    uint256 public totalSupply = 1000000000000000000000000;
    uint8 public decimals = 18;


    // event: transfer
    event Transfer (

        address indexed _from,
        address indexed _to,
        uint _value

    );


    // event: approve
    event Approval (

        address indexed _owner,
        address indexed _spender,
        uint _value

    );


    // mapping
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;


    // constructor
    constructor() {

        balanceOf[msg.sender] = totalSupply;

    }


    // function: transfer
    function transfer(address _to, uint256 _value) public returns (bool success) {

        require(balanceOf[msg.sender] >= _value, "Not enough balance");

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(msg.sender, _to, _value);

        return true;

    }


    // function: transferFrom
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {

        require(balanceOf[_from] >= _value);

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;

        emit Transfer(_from, _to, _value);

        return true;

    }


    // function: approve
    function approve(address _spender, uint256 _value) public returns (bool success) {

        allowance[msg.sender][_spender] = _value;
        
        emit Approval(msg.sender, _spender, _value);

        return true;

    }

}
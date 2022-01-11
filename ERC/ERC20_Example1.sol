// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.6.0;

// creating a contract
contract RKToken {

    // table to map addresses to their balance
    mapping(address => uint256) balances;

    // mapping owner address to those who are allowed to use the contract
    mapping(address => mapping(address => uint256)) allowed;

    // total supply
    uint256 _totalSupply = 500;

    // owner address
    address public owner;

    // event triggered whenever
    // approve(address _spender, uint256 _value)
    // is called
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);


    // event triggered when tokens are transferred
    event Transfer(address indexed _from, address indexed _to, uint256 _value);


    // totalSupply function
    function totalSupply() public view returns (uint256 theTotalSupply) {
    
        theTotalSupply = _totalSupply;
        return theTotalSupply;
    
    }


    // balanceOf function
    function balanceOf(address _owner) public view returns (uint256 balance) {

        return balances[_owner];

    }


    // approve function
    function approve(address _spender, uint256 _amount) public returns (bool success) {
    
        allowed[msg.sender][_spender] = _amount;

        emit Approval(msg.sender, _spender, _amount);

        return true;
    
    }


    function transfer(address _to, uint256 _amount) public returns(bool success) {
    
        if (balances[msg.sender] >= _amount) {

            balances[msg.sender] -= _amount;
            balances[_to] += _amount;

            emit Transfer(msg.sender, _to, _amount);

            return true;

        }

        else {

            return false;

        }
    
    }


    // the function transferFrom is used to transfer tokens on our behalf
    // to a contract address and charge fees
    function transferFrom(address _from,
                          address _to,
                          uint256 _amount)
                          public returns (bool success)
        {

            if(balances[_from] >= _amount && 
               allowed[_from][msg.sender] >= _amount &&
               _amount > 0 &&
               balances[_to] + _amount > balances[_to]
               ) {

                   balances[_from] -= _amount;
                   balances[_to] += _amount;

                   // fire a transfer event for any logic that is listening
                   emit Transfer(_from, _to, _amount);

                   return true;

               }

            else {

                    return false;

            }

        }

    
    // checking whether address is allowed to spend on the owner's behalf
    function allowance(address _owner,
                       address _spender)
                       public view returns (uint256 remaining)
        {

            return allowed[_owner][_spender];

        }

}

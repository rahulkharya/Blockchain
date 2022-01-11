pragma solidity ^0.4.24;

contract Bank {

    struct Account {

        address addr;
        uint amount;

    }

    Account public acc = Account({

        addr : 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,
        amount : 50

    });

    function addAmount(uint _addMoney) public {

        acc.amount += _addMoney;

    }

}

// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract EventStudy{
    event Deposite(address _from, string _name, uint256 _value);

    function deposite(string memory _name) public payable{
        emit Deposite(msg.sender, _name, msg.value);
    }
}
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract MappingStudy{
    //这个数据结构就相当于是一个键值对
    mapping(address=>uint) accounts;

    function get(address _addr) public view returns(uint){
        return accounts[_addr];
    }

    function set(address _addr, uint _balance) public {
        accounts[_addr]=_balance;
    }

    function remove(address _addr) public {
        delete accounts[_addr];
    }
}
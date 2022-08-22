// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Logic1{
    uint private number;

    function setNumber() public {
        number = number + 1;
    }

    function getNumber() public view returns(uint){
        return number;
    }
}
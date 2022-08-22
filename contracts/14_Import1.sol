// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract ImportExample1{
    uint public age = 80;
    string private name="biden";

    function getName() public view returns(string memory){
        return name;
    }
}
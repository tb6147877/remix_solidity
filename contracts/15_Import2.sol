// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./14_Import1.sol";

contract ImportExample2{
    ImportExample1 ie1=new ImportExample1();

    function getAge() public view returns(uint){
        return ie1.age();//记住这里要加括号
    }

    function getName() public view returns(string memory){
        return ie1.getName();
    }
}
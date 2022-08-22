// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

//智能合约的继承
contract A{
    //virtual关键字是必须的，只要子类override父类的函数，这个函数必须加virtual
    function getName() public pure virtual returns(string memory){
        return "A";
    }
}

contract B is A{
    //如果要override必须参数也完全一样
    function getName() public pure override returns(string memory){
        return "B";
    }

    function getAName() public pure returns(string memory){
        return super.getName();
    }
}

//在solidity中，一个contract可以继承多个contract，但我认为这样并不推荐
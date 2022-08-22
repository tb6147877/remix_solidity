// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract A{
    uint private num;

    function setNum(uint _num) public {
        num=_num+1;
    }

    function getNum() public view returns(uint){
        return num;
    }

    //这个函数通常用于合约升级，调用B合约的方法，但是数据仍然保存在A合约中
    function bSetNumDelegateCall(address _bAddr, uint _num) public {
        (bool res,)=_bAddr.delegatecall(abi.encodeWithSignature("setNum(uint256)",_num));
        if(!res) revert();
    }
}

contract B{
    uint private num;

    function setNum(uint _num) public {
        num=_num+2;
    }

    function getNum() public view returns(uint){
        return num;
    }

}
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract A{

    function callBFunction(address _address, uint256 _num, string memory _message) public returns(bool){
        
        //调用的第一种方法，推荐
        /*(bool success,) = _address.call(
            abi.encodeWithSignature("bFunction(uint256,string)",_num,_message)
        );*/

        //调用的第二种方法
        /*bytes4 sig = bytes4(keccak256("bFunction(uint256,string)"));
        bytes memory _bNum = abi.encode(_num);
        bytes memory _bMessage = abi.encode(_message);
        (bool success,) = _address.call(
            abi.encodePacked(sig,_bNum,_bMessage)
        );*/

        //调用的第三种方法，最常用
        bool success = true;
        B contractB = B(_address);
        (uint256 num, string memory message) = contractB.bFunction(_num,_message);
        return success;
    }

}

contract B{
    uint256 public num;
    string public message;

    function bFunction(uint256 _num, string memory _message) public returns(uint256, string memory){
        num=_num;
        message=_message;
        return (num,message);
    }
}
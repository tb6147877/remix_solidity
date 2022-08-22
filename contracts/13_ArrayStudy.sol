// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract ArrayStudy{
    uint[] iArray;
    uint[] iArray2=[1,2,3];
    uint[3] iArray3;

    function getArray() public view returns(uint[] memory){
        return iArray2;
    }

    function getNumberByIndexInArray(uint _index) public view returns(uint){
        return iArray2[_index];
    }

    function getArrayLength() public view returns(uint){
        return iArray3.length;
    }

    function push(uint _val) public {
        iArray2.push(_val);//在数组后面添加一个值
    }

    function pop() public {
        iArray2.pop();//在数组后面删除一个值
    }

    function deleteByIndex(uint _index) public{
        delete iArray2[_index];//将数组某个值设为0
    }
}
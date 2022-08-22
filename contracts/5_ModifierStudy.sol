// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract ModifierStudy{
    address public owner;
    uint256 public account;

    constructor(){
        owner=msg.sender;//意思是在合约的构造函数中把合约的创建者记录下来
        account=0;
    }

    modifier onlyOwner(){
        require(msg.sender==owner, "Only Owner");//意思是只有满足这个条件函数才会执行，否则抛出这条信息
        _;//必须加这个
    }

    modifier largerThan100(uint256 _account){
        require(_account>100, "less than 100");//意思是只有满足这个条件函数才会执行，否则抛出这条信息
        _;//必须加这个
    }

    function updateAccount(uint256 _account) public onlyOwner largerThan100(_account){
        account=_account;
    }
}
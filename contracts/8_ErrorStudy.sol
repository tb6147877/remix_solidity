// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

error Unauthorized(string error);

contract ErrorStudy{
    address payable owner = payable(msg.sender);//在创建合约时记录合约的拥有者

    function withdraw() public{
        if(msg.sender!=owner){
            revert Unauthorized({error:'Unauthorized'});//只有owner才能取款
        }
        owner.transfer(address(this).balance);
    }
}
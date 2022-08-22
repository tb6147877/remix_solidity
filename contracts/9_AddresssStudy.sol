// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract AddressStudy{
    address ownerAddr;

    constructor(){
        ownerAddr=msg.sender;
    }

    //获取合约地址
    function getContractAddress() external view returns(address){
        return address(this);
    }

    //获取与合约交互者地址
    function getSenderAddress() external view returns(address){
        return msg.sender;
    }

    function getOwnerAddress() external view returns(address){
        return ownerAddr;
    }

    function getBalance() external view returns(uint,uint,uint){
        uint contractBalance=address(this).balance;
        uint senderBalance=msg.sender.balance;
        uint ownerBalance=ownerAddr.balance;
        return (contractBalance,senderBalance,ownerBalance);
    }
}

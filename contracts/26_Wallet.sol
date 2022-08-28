// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

//这个钱包所有人都可以往里转钱，但是只有owner可以提现
contract Wallet{
    address payable public owner;

    constructor(){
        owner=payable(msg.sender);
    }

    function withdraw(uint _amount) external {
        require(msg.sender==owner,"Not owner");

        //提款方式1
        //bool sent=payable(msg.sender).send(_amount);
        //require(sent, "send failed!");

        //提款方式2
        //payable(msg.sender).transfer(_amount);

        //提款方式3
        (bool sent,)=owner.call{value:_amount}("");
        require(sent,"send failed!");
    }

    receive() external payable{}//有了这个函数就可以往里转钱了

    function getBalance() external view returns(uint){
        return address(this).balance;
    }
}


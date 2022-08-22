// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ReceiveTokenContract{
    IERC20 myToken;
    address owner;

    constructor(address _tokenAddress){
        myToken=IERC20(_tokenAddress);//将一个此接口的实现类实例地址传进来
        owner=msg.sender;
    }

    //将代币转移到此合约
    //这里转账不能直接转账，需要我们的账户在币的合约那边给此合约一个授权额度，才能把钱转到此合约
    function transferFrom(uint _amount) public{
        myToken.transferFrom(msg.sender,address(this),_amount);
    }

    function getBalance(address _address) public view returns(uint){
        return myToken.balanceOf(_address);
    }

    //销毁自己
    function kill() public{
        myToken.transfer(owner,myToken.balanceOf(address(this)));
        selfdestruct(payable(owner));
    }
}
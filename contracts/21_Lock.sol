// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/*solidity的时间非常方便
1==1 seconds
1 minutes==60 seconds
1 hours==60 minutes
1 days==24 hours
1 weeks==7 days

*/

contract MyChain is ERC20, Ownable{
    bool public isLocked = false;
    uint public timeLock = block.timestamp + 1 minutes;
    constructor() ERC20("WuXueChun", "WXC"){
        _mint(msg.sender, 10000 * 10 ** decimals());
    }

    function transfer(address _to, uint256 _amount) public override returns(bool){
        
        return super.transfer(_to, _amount);
    }

    //这个是ERC20在转账前会调用的一个函数，模板方法模式，转账限制可以写在这里
    function _beforeTokenTransfer(address from, address to, uint256 amount)internal virtual override{
        require(!isLocked, "Transfer was Locked!");//给这个币的转账功能加锁
        require(msg.sender != 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2, "This account cannot transfer!");//某个账户不能转账
        //require(block.timestamp > timeLock, "Time Error");//某个时间段内不能转账
    }

    //只有owner才能设锁
    function setLock() public onlyOwner returns(bool){
        isLocked = true;
        return true;
    }
}
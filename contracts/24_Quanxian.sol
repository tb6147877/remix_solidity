// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts@4.4.1/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.4.1/access/Ownable.sol";


contract WuxueChain is ERC20, Ownable{
    constructor() ERC20("WuxueChain", "WXC"){
        _mint(msg.sender, 10000*10**decimals());
    }

    //onlyOwner的权限是只有创建者才能执行，意思是只有创建者才能把币挖给别人
    //renounceOwnership()可以删除owner，任何人都无法调用这个函数
    function mint(address to, uint256 amount) public onlyOwner{
        _mint(to, amount);
    }
}
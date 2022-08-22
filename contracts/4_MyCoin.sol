// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyCoin is ERC20{
    constructor() ERC20("MyCoin","WXCC"){
        //ERC20的精度默认被设置为小数点后18位，decimals的默认值就是18，如果要更改自己币的小数点位数就要给decimals重新赋值
        //**是n次方的运算符
        //所以这个代码的意思是初始给自己10000个token，10 ** decimals()的意思是要把18位小数点填平
        //其实在ERC20中，小数点就是显示作用，其实token的最小单位始终是1
        _mint(msg.sender, 10000 * 10 ** decimals());
    }
}
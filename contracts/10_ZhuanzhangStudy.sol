// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract ZhuanzhangStudy{
    function send(address payable _to) public payable{
        bool isSend = _to.send(msg.value);//_to是被转到的地址，msg.value是附加在这个调用里的value
        require(isSend, "Send fail");
    }

    function transfer(address payable _to) public payable{
        _to.transfer(msg.value);//_to是被转到的地址，msg.value是附加在这个调用里的value
    }

    function calls(address payable _to) public payable{
        (bool isSend, )=_to.call{value:msg.value, gas:5000}("");//_to是被转到的地址，msg.value是附加在这个调用里的value
        require(isSend, "Send fail");
    }
}
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Receiver{
    event Received(address caller, uint amount, string message);

    //当转钱进这个智能合约的时候就会调这个方法,但只用于处理call函数data参数为空情况
    receive() external payable{
        emit Received(msg.sender,msg.value, "Received was called");
    }

    //当call函数data参数不为空，但又匹配不上任何对应函数时,会fallback到这个函数
    fallback() external payable{
        emit Received(msg.sender,msg.value, "Fallback was called");
    }

    function foo(string memory _message, uint _y) public payable returns(uint){
        emit Received(msg.sender,msg.value, _message);
        return _y;
    }


    function getAddress() public view returns(address){
        return address(this);
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }
}

//caller这个合约调用receiver这个合约里的函数
contract Caller{
    Receiver receiver;

    constructor(){
        receiver = new Receiver();
    }

    event Response(bool success, bytes data);

    function testCall(address payable _addr, uint _y) public payable{
    
        (bool success, bytes memory data) = _addr.call{value:msg.value}(
            abi.encodeWithSignature("foo(string,uint256)", "call foo",_y)
        );//函数名字符串，后面跟这个函数两个参数的值

        emit Response(success,data);
    }

    function testCall1(address payable _addr) public payable{
        (bool success, bytes memory data) = _addr.call{value:msg.value}("");
    

        emit Response(success,data);
    }
    

    function getAddress() public view returns(address){
        return receiver.getAddress();
    }

    function getBalance() public view returns(uint){
        return receiver.getBalance();
    }
}


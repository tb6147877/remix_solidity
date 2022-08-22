// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

interface ILogic{
    function setNumber() external;
    function getNumber() external view returns(uint);
}

contract Proxy{
    ILogic public logic;

    function setLogicAddress(address _logicAddress) public {
        logic = ILogic(_logicAddress);
    }

    function getLogicAddress() public view returns(address){
        return address(logic);
    }

    function setNumber() public {
        logic.setNumber();
    }

    function getNumber() public view returns(uint){
        return logic.getNumber();
    }
}
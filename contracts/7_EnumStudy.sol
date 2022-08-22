// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract EnumStudy{
    enum Status {
        ON,
        OFF
    }

    Status status;

    function getStatus() view external returns(Status){
        return status;
    }

    function setStatus(Status _status) external{
        status = _status;
    }

    function resetStatus() external{
        delete status;
    }

    function getValueByKey(string memory _status) pure external returns(Status){
        if(keccak256(bytes(_status))==keccak256(bytes('OFF'))) return Status.OFF;
        if(keccak256(bytes(_status))==keccak256(bytes('ON'))) return Status.ON;
        revert();
    }

}
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract SwappableToken is ERC20{
    constructor(string memory Name, string memory Symbol, uint InitialSupply) ERC20(Name,Symbol){
        _mint(msg.sender, InitialSupply * 10 ** decimals());
    }

    function approve(address owner, address spender, uint256 amount) public returns (bool) {
        _approve(owner, spender, amount);
        return true;
    }
}

contract DEX2{
    using SafeMath for uint;
    address public token1;
    address public token2;

    constructor(address _token1, address _token2){
        token1=_token1;
        token2=_token2;
    }

    function swap(address from, address to, uint amount) public {
        //验证必须是token1和token2交换
        require((from==token1&&to==token2)||(from==token2&&to==token1),"Invalid tokens");
        //验证交换方的币够不够
        require(SwappableToken(from).balanceOf(msg.sender)>=amount, "Not enough to swap");

        uint swap_amount = get_swap_price(from, to, amount);

        SwappableToken(from).transferFrom(msg.sender, address(this), amount);
        SwappableToken(to).approve(address(this), swap_amount);
        SwappableToken(to).transferFrom(address(this), msg.sender, swap_amount);

    }

    //添加流动性前要先approve
    function add_liquidity(address token_address, uint amount) public{
        SwappableToken(token_address).transferFrom(msg.sender, address(this), amount);
    }

    function get_swap_price(address from, address to, uint amount) public view returns(uint){
        //恒定乘积做市商模型，x*y=k
        return ((amount*SwappableToken(to).balanceOf(address(this)))/SwappableToken(from).balanceOf(address(this)));
    }

    function approve(address token, uint amount) public{
        SwappableToken(token).approve(msg.sender, address(this), amount);
    }
}
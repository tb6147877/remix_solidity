// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

//library就是一个类库（工具类），也是一个合约可以部署在区块链上，
//它不能被继承；它里面不能存放区块链上的数据（不能是状态变量，只能是常量）；也不能接收代币
//不能有构造函数；部署一次就能多次使用，用得好可以省非常多的gas
//安全的加减

library SafeMath{
    function sub(uint256 a, uint256 b) internal pure returns(uint256){
        assert(b<=a);
        return a-b;
    }
    function add(uint256 a, uint256 b) internal pure returns(uint256){
        uint256 c=a+b;
        assert(c>=a);
        return c;
    }
}

//ERC20的抽象与行为
interface IERC20{
    function getAddress() external view returns(address);
    function totalSupply() external view returns(uint256);
    function balanceOf(address account) external view returns(uint256);
    function allowance(address owner, address spender) external view returns(uint256);

    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address owner, address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Tranfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

}

//手写ERC20的实现
contract ERC20Basic is IERC20{
    string public constant name="ERC20-XiaochunCoin";//链上数据
    string public constant symbol="ERC-XCC";//链上数据
    uint8 public constant decimals=18;//链上数据

    mapping(address=>uint256) balances;
    mapping(address=>mapping(address=>uint256)) allowed;

    uint256 totalSupply_ = 10 ether;

    using SafeMath for uint256;//声明library

    constructor(){
        balances[msg.sender]=totalSupply_;
    }

    function getAddress() public override view returns(address){
        return address(this);
    }

    function totalSupply() public override view returns(uint256){
        return totalSupply_;
    }

    function balanceOf(address tokenOwner) public override view returns(uint256){
        return balances[tokenOwner];
    }

    //从转账发起账户减去对应的钱，给收钱账户加上对应的钱
    function transfer(address receiver, uint256 numTokens) public override returns(bool){
        require(numTokens<=balances[msg.sender]);
        balances[msg.sender]=balances[msg.sender].sub(numTokens);//比较特殊的方式调用library里面的函数
        balances[receiver]=balances[receiver].add(numTokens);
        emit Tranfer(msg.sender,receiver,numTokens);
        return true;
    }

    function approve(address owner, address delegate, uint256 numTokens) external override returns (bool){
        allowed[owner][delegate]=numTokens;
        emit Approval(owner,delegate,numTokens);
        return true;
    }

    function allowance(address owner, address delegate) external override view returns(uint256){
        return allowed[owner][delegate];
    }

    function transferFrom(address owner, address buyer, uint256 numTokens) external override returns (bool){
        require(numTokens<=balances[owner]);
        require(numTokens<=allowed[owner][msg.sender]);

        balances[owner]=balances[owner].sub(numTokens);
        allowed[owner][buyer]=allowed[owner][buyer].sub(numTokens);
        balances[buyer]=balances[buyer].add(numTokens);
        emit Tranfer(owner,buyer,numTokens);
        return true;
    }
}

//去中心化交易所代码
contract DEX{
    event Bought(uint256 amount);
    event Sold(uint256 amount);

    IERC20 public token;

    constructor(){
        token=new ERC20Basic();
    }

    function buy() payable public{
        uint256 amountToBuy=msg.value;
        uint256 dexBalance=token.balanceOf(address(this));
        require(amountToBuy>0, "You need to send some ether!");
        require(amountToBuy<=dexBalance, "Not enough tokens in the reverse!");
        token.transfer(msg.sender,amountToBuy);
        emit Bought(amountToBuy);
    }

    function sell(uint256 amount) payable public{
        require(amount>0, "You need to sell at least 1 token!");

        uint256 allowance =token.allowance(msg.sender,address(this));
        require(allowance>=amount,"Check the token allowance!");

        token.transferFrom(msg.sender,address(this),amount);
        emit Sold(amount);
    }

    function getDexBalance() public view returns(uint256){
        return token.balanceOf(address(this));
    }

    function getOwnerBalance() public view returns(uint256){
        return token.balanceOf(msg.sender);
    }

    function getAddress() public view returns(address){
        return address(this);
    }

    function getTokenAddress() public view returns(address){
        return token.getAddress();
    }

    function getTotalSupply() public view returns(uint256){
        return token.totalSupply();
    }

    function getSenderAddress() public view returns(address){
        return address(msg.sender);
    }

    function getAllowance() public view returns(uint256){
        uint256 allowance=token.allowance(msg.sender,address(this));
        return allowance;
    }

    function approve(uint256 amount) public returns(bool){
        bool isApprove=token.approve(msg.sender,address(this),amount);
        return isApprove;
    }
}
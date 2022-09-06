// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.7.3/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts@4.7.3/access/Ownable.sol";

contract MyToken1155 is ERC1155, Ownable {
    //发行三个代币，每个代币都有一个ID，都可以有自己的数量，所以一个ERC1155既可以包含NFT也可以包含FT
    uint256 public constant TOKEN_A=0;
    uint256 public constant TOKEN_B=1;
    uint256 public constant TOKEN_C=2;

    //这里URI指向的是NFT的元数据，id是代币id；opensea要求了严格的json文件的格式
    constructor() ERC1155("https://thinkingchain.app/{id}.json") {
        _mint(msg.sender, TOKEN_A, 100**18,"");
        _mint(msg.sender, TOKEN_B, 10,"");
        _mint(msg.sender, TOKEN_C, 10000,"");
    }

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function mint(address account, uint256 id, uint256 amount, bytes memory data)
        public
        onlyOwner
    {
        _mint(account, id, amount, data);
    }

    //批量mint
    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        public
        onlyOwner
    {
        _mintBatch(to, ids, amounts, data);
    }
}
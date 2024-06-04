// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract CustomToken is ERC20{
    constructor(string memory name,string memory symbol ) ERC20(name,symbol){
        // _mint(address account, uint256 value)
        _mint(msg.sender, 10000000 * 10 ** 18);
    }
}

contract SwapToken {
    string[] public tokens = ["coinA","coinB", "coinC"];

    mapping(string => ERC20) tokenInstanceMap;

    // 0.001 ether 
    uint valuetoken = 1000000000000000;

    constructor(){
        for(uint i = 0; i < tokens.length; i++){
            CustomToken token = new CustomToken(tokens[i],tokens[i]);
            tokenInstanceMap[tokens[i]] = token;
        }
    }

    function getName(string memory tokenName) public view returns(string memory){
        return tokenInstanceMap[tokenName].name();
    }

        function getSymbol(string memory tokenName) public view returns(string memory){
        return tokenInstanceMap[tokenName].symbol();
    }

    function getBalance(string memory tokenName , address _address) public view returns(uint){
        return tokenInstanceMap[tokenName].balanceOf(_address);
    }

    function getTokenAddress(string memory tokenName)public view returns(address){
        return address(tokenInstanceMap[tokenName]);
    }

    function swapEthToToken(string memory tokenName) public payble returns(uint) {
        uint inputValue = msg.value;
        uint outputValue = (inputValue / valuetoken) * 10 ** 18; // get quantity token
        require(tokenInstanceMap[tokenName].transfer(msg.sender, outputValue), "Transfer failed");
        return outputValue;

    }

    function swapTokenToEth(string memory tokenName, uint256 _amount) public returns(uint){
        uint amount = _amount / 10 ** 18;// convert wei to eth
        uint transferred = amount * valuetoken;
        require(address(this).balance >= transferred,"Withdraw amount exceeds balance");
        payable(msg.sender).transfer(transferred);
        require(tokenInstanceMap[tokenName].transferFrom(msg.sender,address(this), _amount));
        return transferred;
    }

    function swapTokenToToken(string memory tokenName, string memory destTokenName, uint256 _amount) public {
        require(tokenInstanceMap[tokenName].transferFrom(msg.sender ,address(this) ,_amount));
        require(tokenInstanceMap[destTokenName].transfer(msg.sender,_amount));
    }

    function getEthBalance()public view returns(uint){
        return address(this).balance;
    }
}
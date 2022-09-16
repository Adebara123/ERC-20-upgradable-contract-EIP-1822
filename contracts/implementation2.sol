//SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./proxiable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract ImplementationB is Proxiable, ERC20("Ayomide", "AYO") {
    address public owner;
    string tokenName;
    string tokenSymbol;

    function constructor1() public {
        require(owner == address(0), "Already initalized");
        owner = msg.sender;
        tokenName = "Ayomide";
        tokenSymbol = "AYO";
    }

    function mintToken (address recieverAddr, uint amount) public  {
          _mint(recieverAddr, amount);
    } 

     function transferOut (address addr, uint  _amount)external onlyOwner  {

        uint bal = balanceOf(address(this));
        require (bal >= _amount , "You cant send more than balance");
        _transfer(address(this), addr , _amount );
        uint burnable = (totalSupply() * 1) / (totalSupply() * 10000);
        _burn(addr, burnable);
    }

    function name() public view virtual override returns (string memory) {
        return tokenName;
    }

    
    function symbol() public view virtual override returns (string memory) {
        return tokenSymbol;
    }




    function updateCode(address newCode) onlyOwner public {
        updateCodeAddress(newCode);
    }

    function encode() external pure returns (bytes memory) {
        return abi.encodeWithSignature("constructor1()");
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner is allowed to perform this action");
        _;
    }
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts@4.8.2/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.8.2/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts@4.8.2/access/AccessControl.sol";

contract CommunityToken is ERC20, ERC20Burnable, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    uint public numPay;
    string private business_name;
    address private business_address;


    constructor() ERC20("CommunityToken", "CMT") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);

    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    function transfer(address to, uint amount) public virtual override returns(bool) {
        address owner = _msgSender();
        _transfer(owner, to, amount);

        return true;
    }

    function Tip(address from, address to, uint256 amount) public returns(bool) {
    
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        ++numPay;
        return true;
    }


    function RegisterBusiness(string memory name, address addre) public  {
        business_name = name;
        business_address = addre;

    }

    function TransactTokens(address account, uint amount) public {
        require(numPay >= 3, "Tokens not ready to be used!");
        require(business_address == account, "Business not Registered");
        numPay = 0;
        _burn(account, amount);
      
       
    }



}

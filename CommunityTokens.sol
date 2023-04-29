// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts@4.8.2/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.8.2/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts@4.8.2/access/AccessControl.sol";

contract CommunityToken is ERC20, ERC20Burnable, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    uint public numPay;
    string public business_name;

    struct Business {
        string name;
        address addr;
    }
    Business public registeredBusiness;

    uint public requiredPayments;

    event Purchased (address indexed spender, uint indexed cost);
    event Tipsent (address indexed sender, address indexed  receiver, uint indexed value);
    event Registered (string indexed business_name, address indexed _address);


    constructor(uint _requiredPayments) ERC20("CommunityToken", "CMT") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
        requiredPayments = _requiredPayments;
    }
    //only be called by addressed registered under the minter_role to mint new tokens to
    //a sprcific address "to"
    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }
    //check ERC20.sol
    function transfer(address to, uint amount) public virtual override returns(bool) {
        address owner = _msgSender();
        _transfer(owner, to, amount);

        return true;
    }
    //allows tokens to be sent from one address to another.
    //have additional allowance check.
    function Tip(address from, address to, uint256 amount) public returns(bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        ++numPay;  //a variable that increment anytime the transaction goes

        emit Tipsent(from, to, amount);
        return true;
    }
    //address that is registered here has the ability to call the 'transacttoken()' function
    function registerBusiness(string memory name, address addre) public {
        registeredBusiness = Business(name, addre);
        emit Registered(registeredBusiness.name, registeredBusiness.addr);
    }

    function removeBusiness() public {
        delete registeredBusiness;
    }
    //burn specific amount from business address.
    // requirement: business must be registered and the numpay will be greater than required payment.
    // this is to make sure that transaction must occur 3 times 
    function transactTokens() public {
        require(registeredBusiness.addr != address(0), "Business not registered");
        require(numPay >= requiredPayments, "Tokens not ready to be used!");
        _burn(registeredBusiness.addr, balanceOf(registeredBusiness.addr));
        numPay = 0;

        emit Purchased (registeredBusiness.addr, balanceOf(registeredBusiness.addr));
    }
}

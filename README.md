# Marketplace Smart Contract

This is a simple Marketplace smart contract written in Solidity. It allows users to register, list items for sale, and view item details.

## Features

- **User Registration:** Users can register with a unique username.
- **Item Listing:** Registered users can list items for sale with a name and price.
- **View Item:** Anyone can view the details of a listed item by its ID.

## Getting Started

### Executing Program
o run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at [Remix Ethereum](https://remix.ethereum.org/).

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract MarketplaceApp {

    struct Item {
        string name;
        string description;
        bool exists;
    }
    struct User {
        string username;
        bool registered;  
    }
    
    // User Functionality

    mapping(address => User) users;

    function registerUser(string memory username, address _addr) public returns(string memory) {
        if(users[_addr].registered) revert("Already registered");

        users[_addr] = User(username, true);
        return string(abi.encodePacked(username, " successfully registered"));
    }

    // Item Functionality

    mapping(address => Item) items;

    function listItem(string memory name, string memory description, address _user) public {
        assert(users[_user].registered);
        items[_user] = Item(name, description, true);
    }

    function viewItem(address _user) public view returns(Item memory) {
        if(!items[_user].exists) revert("Item doesn't exist");
        return items[_user];
    }

    // Admin Functionality

    address admin;

    constructor() {
        admin = msg.sender;
    }

    function deleteItem(address _user, address _adminAddr) public {
        require(admin == _adminAddr, "Unauthorized");
        items[_user].exists = false;
    }
}
//0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
//0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
```
To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.26" (or another compatible version), and then click on the "Compile myContact.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "myContract" contract from the dropdown menu, and then click on the "Deploy" button.


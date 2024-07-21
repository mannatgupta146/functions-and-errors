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

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Marketplace {

    struct Item {
        string name;
        uint256 price;
        address seller;
    }

    struct User {
        string username;
        bool isRegistered;
    }

    mapping(address => User) public users;
    mapping(uint256 => Item) public items;
    uint256 public itemCount;

    event UserRegistered(address indexed userAddress, string username);
    event ItemListed(uint256 indexed itemId, string name, uint256 price, address indexed seller);

    // Function to register a new user
    function registerUser(string memory username) public {
        require(!users[msg.sender].isRegistered, "User already registered");
        
        users[msg.sender] = User(username, true);
        
        emit UserRegistered(msg.sender, username);
    }

    // Function to list a new item for sale
    function listItem(string memory name, uint256 price) public {
        require(users[msg.sender].isRegistered, "User not registered");
        require(price > 0, "Price must be greater than zero");
        
        itemCount++;
        items[itemCount] = Item(name, price, msg.sender);
        
        emit ItemListed(itemCount, name, price, msg.sender);
    }

    // Function to get details of an item by its ID
    function getItem(uint256 itemId) public view returns (Item memory) {
        require(itemId > 0 && itemId <= itemCount, "Item does not exist");
        return items[itemId];
    }
}
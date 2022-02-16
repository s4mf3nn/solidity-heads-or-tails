// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Owner {
  address owner;

  // Set contract deployer as owner
  constructor() {
    owner = msg.sender;
  }

  modifier isOwner() {
    require(msg.sender == owner, "User is not the contract owner.");
    _;
  }

  // Return owner address
  function getOwner() external view returns (address) {
    return owner;
  }

  // Contract owner can transfer ownership to another address
  function changeOwner(address _newOwner) external {
    require(msg.sender == owner);
    owner = _newOwner;
  }
}
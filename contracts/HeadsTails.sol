// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./Manager.sol";

contract HeadsTails is Manager {
  // Transfer funds to the contract upon deployment
  constructor() payable {
    payable(address(this)).transfer(msg.value);
  }

  modifier betValidation(uint _userChoice) {
    require(msg.value >= 2 ether, "The bet must be greater or equal than 2 ETH.");
    require(msg.value <= maxBetETH, "The bet must be lower or equal to the max defined amount.");
    require(msg.value * 2 <= address(this).balance, "Insufficient contract balance.");
    require(_userChoice <= 1, "Bet number must be 0 or 1.");
    _;
  }

  // Place a bet, the contract owner can't use this function
  function bet(uint _userChoice) external payable betValidation(_userChoice) {
    require(msg.sender != owner, "Bettor can't be the contract owner.");
    uint number = randomNumber(2);
    uint betValueETH = msg.value - betFeeETH;

    // Send fee to the contract owner
    payable(owner).transfer(betFeeETH);

    // Send the reward to the bettor if the number drawn matches the one chosen
    if (_userChoice == number) {
        payable(msg.sender).transfer(betValueETH + msg.value);
    }
  }
}
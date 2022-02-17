// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "./Manager.sol";
import "./SafeMath.sol";

contract HeadsTails is Manager {

  using SafeMath for uint;

  // Transfer funds to the contract upon deployment
  constructor() payable {
    payable(address(this)).transfer(msg.value);
  }

  modifier notOwner() {
    require(msg.sender != owner, "Bettor can't be the contract owner.");
    _;
  }

  modifier betValidation(uint _userChoice) {
    require(msg.value >= 2 ether, "The bet must be greater or equal than 2 ETH.");
    require(msg.value <= maxBetETH, "The bet must be lower or equal to the max defined amount.");
    require(msg.value * 2 ether <= address(this).balance, "Insufficient contract balance."); // FIXME not working
    require(_userChoice <= 1, "Bet number must be 0 or 1.");
    _;
  }

  // Place a bet, the contract owner can't use this function
  function bet(uint8 _userChoice) external payable notOwner betValidation(_userChoice) stopInEmergency {
    uint number = randomNumber(2);
    uint betValueETH = msg.value.sub(betFeeETH);
    uint reward = betValueETH.add(msg.value);

    // Send fee to the contract owner
    payable(owner).transfer(betFeeETH);

    // Send the reward to the bettor if the number drawn matches the one chosen
    if (_userChoice == number) {
        payable(msg.sender).transfer(reward);
    }
  }
}
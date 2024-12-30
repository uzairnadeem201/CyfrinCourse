// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    uint256 public minimumUsd = 5e18;
    address[] public senders;
    mapping(address => uint256) public addressToamountfunded;

    function Fund() public payable {
        require(getConversionRate(msg.value) >= minimumUsd, "Didn't Send Enough Eth");
        senders.push(msg.sender);
        addressToamountfunded[msg.sender] = addressToamountfunded[msg.sender]+ msg.value;
        
    }

    function Withdraw() public {
        // Logic for withdrawing funds
    }

    function getPrice() public view returns (uint256) {
        // Update this address for your network
        //Address: 0x690cC3A988F6c9C5F35713ad4175897b439eD3c6
        AggregatorV3Interface priceFeed = AggregatorV3Interface( 0x690cC3A988F6c9C5F35713ad4175897b439eD3c6);
        (, int256 price, , , ) = priceFeed.latestRoundData();
        return uint256(price * 1e18); // Convert to 18 decimals
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e10;
        return ethAmountInUsd;
    }
    function getVersion() public view returns(uint256) {
        return AggregatorV3Interface(0x690cC3A988F6c9C5F35713ad4175897b439eD3c6 ).version();

    }
}
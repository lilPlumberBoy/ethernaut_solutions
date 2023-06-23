// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../contracts/utils/TestWithSetup.sol";
import "../contracts/4Telephone.sol";
import "../contracts/attackers/4TelephoneAttack.sol";

contract TelephoneTest is TestWithSetup {
    Telephone private challengeContract;
    TelephoneAttack private attackContract;

    function setUp() public override {
        TestWithSetup.setUp();
        vm.prank(owner);
        challengeContract = new Telephone();
        vm.startPrank(user, user); // 2nd variable here overrides tx.origin
        attackContract = new TelephoneAttack();
    }

    function testSolution() public {
        assertEq(challengeContract.owner(), owner);
        attackContract.attack(address(challengeContract));
        assertEq(challengeContract.owner(), user);
        vm.stopPrank();
    }
}

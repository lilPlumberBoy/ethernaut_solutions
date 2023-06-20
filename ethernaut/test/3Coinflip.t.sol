// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/utils/TestWithSetup.sol";
import "../src/3Coinflip.sol";

contract TestCoinFlip is TestWithSetup {
    CoinFlip public contractToTest;

    function setUp() public override{
        TestWithSetup.setUp();
        vm.prank(owner);
        contractToTest = new CoinFlip();
        vm.startPrank(user);
    }

    function buh() public {
        assertEq(contractToTest.consecutiveWins(), 0);
    }
}
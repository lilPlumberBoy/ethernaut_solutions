// SPDX-License-Identifier: MIT
pragma experimental ABIEncoderV2;
pragma solidity ^0.6.2;

import "../contracts/2Fal1out.sol";
import "forge-std/Test.sol";

contract Fal1outTest is Test{
    Fallout public contractToTest;
    address user = address(1234);
    address owner = address(5678);

    function setUp() public {
        vm.prank(owner);
        contractToTest = new Fallout();
        vm.startPrank(user);
    }

    function testcallFal1out() public {
        assertEq(contractToTest.owner(), address(0));
        contractToTest.Fal1out();
        assertEq(contractToTest.owner(), user);
    }
}

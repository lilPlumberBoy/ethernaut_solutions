// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.13;

interface IToken {
    function transfer(address, uint256) external returns (address);
    function balanceOf(address) external returns (uint256);
}

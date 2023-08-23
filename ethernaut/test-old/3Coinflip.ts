// import hre from 'hardhat';
import {ethers} from "hardhat"
import chai from "chai"
import {mine} from "@nomicfoundation/hardhat-toolbox/network-helpers"

const { expect } = chai

describe("CoinFlipAttack", function (){
    it("Should attack the CoinFlip contract", async function () {
        const challengeFactory = await ethers.getContractFactory("CoinFlip")
        const challengeContract = await challengeFactory.deploy()
        await challengeContract.waitForDeployment()

        const attackFactory = await ethers.getContractFactory("CoinFlipAttack")
        const attackContract = await attackFactory.deploy()
        await attackContract.waitForDeployment()
        let currentWins = 0

        while(currentWins < 10){
            await attackContract.guessFlip(String(challengeContract["target"]))
            currentWins = Number(await challengeContract.consecutiveWins())
            await mine(1)
        }
        expect(currentWins).to.be.equal(10)
    });
});
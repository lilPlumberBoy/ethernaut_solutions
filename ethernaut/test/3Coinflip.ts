// import hre from 'hardhat';
import {ethers} from "hardhat"
import chai from "chai"
import { mine } from "@nomicfoundation/hardhat-network-helpers";

const { expect } = chai


describe("CoinFlipAttack", function (){
    it("Should attack the CoinFlip contract", async function () {
        const CoinflipFactory = await ethers.getContractFactory("CoinFlip")
        const coinFlip = await CoinflipFactory.deploy()
        await coinFlip.waitForDeployment()
        console.log("buh")
        console.log("coinFlip deployed to: ", coinFlip["target"])
        console.log("coinFlip consecutive wins: ", String(await coinFlip.consecutiveWins()))

        const CoinflipAttackFactory = await ethers.getContractFactory("CoinFlipAttack")
        const coinFlipAttack = await CoinflipAttackFactory.deploy()
        await coinFlipAttack.waitForDeployment()
        let currentWins = 0

        while(currentWins < 10){
            await coinFlipAttack.guessFlip(String(coinFlip["target"]))
            currentWins = Number(await coinFlip.consecutiveWins())
            await mine(1)
        }
        expect(currentWins).to.be.equal(10)
    });
});
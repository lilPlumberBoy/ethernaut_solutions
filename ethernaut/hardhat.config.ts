/** @type import('hardhat/config').HardhatUserConfig */
import "@nomicfoundation/hardhat-toolbox";
import dotenv from "dotenv";

dotenv.config()
console.log(process.env.RPC_URL)
module.exports = {
  networks: {
    goerli: {
      url: process.env.RPC_URL,
      chainId: 5,
      // url: "https://eth-goerli.g.alchemy.com/v2/"+process.env.ALCHEMY_API_KEY, //TODO: Does not work but prints fine
      accounts: [process.env.PRIVATE_KEY]
    },
  },
  solidity: {
    compilers: [
      {
        version: "0.8.17",
        settings: {
          optimizer: {
            enabled: true,
            runs: 10000,
          },
        },
      },
      {
        version: "0.8.6",
        settings: {
          optimizer: {
            enabled: true,
            runs: 10000,
          },
        },
      },
      {
        version: "0.6.12",
        settings: {
          optimizer: {
            enabled: true,
            runs: 10000,
          },
        },
      },
      {
        version: "0.5.16",
      },
    ],
  },
};

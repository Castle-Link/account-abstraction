# <h1> Account abstraction by Castle </h1>

**Repository for Castle's Account Abstraction Smart contract Implementation**

## Getting Started

### Setup

1. Install [Foundry](https://github.com/foundry-rs/foundry).
2. Get an Alchemy API key.
3. Create a .env file in the root of this directory with the following.

```
ALCHEMY_API_KEY=sample-key
RPC_URL=https://eth-goerli.g.alchemy.com/v2/
```

### Running Foundry tests

1. Create two terminals.
2. First terminal will run `anvil`. Run the following script.

```sh
source .env # This will import all of your environment variables in the terminal
anvil --fork-url $RPC_URL$ALCHEMY_API_KEY # This will create a local Ethereum node that will be forked from the network of your choosing
```

3. In the second terminal, you can run `forge install`.
4. To kick off your tests, run `forge test --fork-url http://localhost:8545`.

## Notes

Whenever you install new libraries using Foundry, make sure to update your remappings.txt file by running:

```sh
forge remappings > remappings.txt
```

This is required because we use hardhat-preprocessor and the remappings.txt file to allow Hardhat to resolve libraries you install with Foundry.

## Definitions

### Foundry

#### Anvil

#### Cast

#### Forge

## Latest

1. Create2 address is not matching the deployed address... see what's going on with the getAddress function
   (this is true for both the contract we created and the one that is created by eth-infinitism).

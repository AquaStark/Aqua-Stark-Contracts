![Dojo Starter](./assets/cover.png)

<picture>
  <source media="(prefers-color-scheme: dark)" srcset=".github/mark-dark.svg">
  <img alt="Dojo logo" align="right" width="120" src=".github/mark-light.svg">
</picture>

<a href="https://x.com/ohayo_dojo">
<img src="https://img.shields.io/twitter/follow/dojostarknet?style=social"/>
</a>
<a href="https://github.com/dojoengine/dojo/stargazers">
<img src="https://img.shields.io/github/stars/dojoengine/dojo?style=social"/>
</a>

[![discord](https://img.shields.io/badge/join-dojo-green?logo=discord&logoColor=white)](https://discord.com/invite/dojoengine)
[![Telegram Chat][tg-badge]][tg-url]

[tg-badge]: https://img.shields.io/endpoint?color=neon&logo=telegram&label=chat&style=flat-square&url=https%3A%2F%2Ftg.sumanjay.workers.dev%2Fdojoengine
[tg-url]: https://t.me/dojoengine

# Dojo Starter: Official Guide

A quickstart guide to help you build and deploy your first Dojo provable game.

Read the full tutorial [here](https://dojoengine.org/tutorial/dojo-starter).

## Running Locally

#### Terminal one (Make sure this is running)

```bash
# Run Katana
katana --dev --dev.no-fee
```

#### Terminal two

```bash
# Build the example
sozo build

# Inspect the world
sozo inspect

# Migrate the example
sozo migrate

# Start Torii
# Replace <WORLD_ADDRESS> with the address of the deployed world from the previous step
torii --world <WORLD_ADDRESS> --http.cors_origins "*"
```

## Docker
You can start stack using docker compose. [Here are the installation instruction](https://docs.docker.com/engine/install/)

```bash
docker compose up
```
You'll get all services logs in the same terminal instance. Whenever you want to stop just ctrl+c

---

## Contribution

1. **Report a Bug**

    - If you think you have encountered a bug, and we should know about it, feel free to report it [here](https://github.com/dojoengine/dojo-starter/issues) and we will take care of it.

2. **Request a Feature**

    - You can also request for a feature [here](https://github.com/dojoengine/dojo-starter/issues), and if it's viable, it will be picked for development.

3. **Create a Pull Request**
    - It can't get better then this, your pull request will be appreciated by the community.

Happy coding!

World  | Contract Address                                                   | Class Hash                                                         
--------+--------------------------------------------------------------------+--------------------------------------------------------------------
 Synced | 0x039742ef7f9576ec90c4741bfca29f9a6f6ced4ade5c018892fc3bb28a1b3e61 | 0x04c60dc46a8ca8bb47675b7b914053cef769afbf0e340523187336b72bd71d1f 

 Namespaces  | Status | Dojo Selector                                                      
-------------+--------+--------------------------------------------------------------------
 aqua_stark4 | Synced | 0x05f8fb5acaf6ad456de318ed1c2c1bcd23badff8dd9cd14dd3d914bbd795c697 

 Contracts             | Status  | Is Initialized | Dojo Selector                                                      | Contract Address                                                   
-----------------------+---------+----------------+--------------------------------------------------------------------+--------------------------------------------------------------------
 aqua_stark4-AquaStark | Updated | true           | 0x041f30262b4e47ee894bfe22d3acc77ad635cb23a9d4d8aab4099a7299c23846 | 0x01b896a63bf83c38a90e6e2ab34e5cb51a3a80c26e2eeb2b852765d224453f63 

 Models                        | Status | Dojo Selector                                                      
-------------------------------+--------+--------------------------------------------------------------------
 aqua_stark4-AddressToUsername | Synced | 0x0011196ad869e7822008cb396ddb2ab8ef3c9a6216e4ac052d88ae168d71512c 
 aqua_stark4-Aquarium          | Synced | 0x05c30d2c3c939956713a02b1e1c380a11fe2792e1e772214b24aaf8d1fd29ee7 
 aqua_stark4-AquariumCounter   | Synced | 0x02dff73a18adce22b1ba9323052b69a37ff3c53f3d8c68d9e62137e1fa21f431 
 aqua_stark4-AquariumFishes    | Synced | 0x0498c3796ebaab82bd90c6799c3bc0cb0532971aa44da8806540d96f1abd0b9a 
 aqua_stark4-AquariumOwner     | Synced | 0x0660201c213f132e3a3149ead99551882689cf84eb6b91bd52e1344777115edb 
 aqua_stark4-Decoration        | Synced | 0x0548cf5f27515ebfc4ced0b57ac17a3bc4debf7a1ea81c2a9d3fec0fcce8156d 
 aqua_stark4-DecorationCounter | Synced | 0x07c7e84cfe069ca48424cd85616aa99d6f0e8064259b11ee90fb34d33ddbf4fd 
 aqua_stark4-Fish              | Synced | 0x02a63350dc7ba4866b5d501db3c72404161651c34b2ef505b1eabee0a28e5d47 
 aqua_stark4-FishCounter       | Synced | 0x0552cefb8e2372db428731d0c8a91de72593f8da7802f8f10f37611c50434db1 
 aqua_stark4-FishOwner         | Synced | 0x01c5bbccc93b6237a7f10cff7a374e16bdbe234a760a74e71733142d35d88337 
 aqua_stark4-Game              | Synced | 0x069b20d1d0d8b175d703695efb831cb6dea597ee66d96cb222cfe725795cbd12 
 aqua_stark4-GameCounter       | Synced | 0x068d8f47eb2331f7f4446e38a65c4e8ea6d0994dd22e370d0dbd23058c21ece5 
 aqua_stark4-Player            | Synced | 0x03a0729ca73619d3f9e0f6bd25327f936e95286c19edce424f0a9b07611e1ddd 
 aqua_stark4-PlayerCounter     | Synced | 0x04070898203db11770b9884e154718d2feaa0e53dcad7d017fe24027fcd38ba3 
 aqua_stark4-PlayerFish        | Synced | 0x000c0e95254e5bd559da5b7fb72a9f5098e8fef67d1696c2f090079e6d36eb85 
 aqua_stark4-PlayerFishes      | Synced | 0x06b1daa51a89e0acf59becf5a847fb0c86063215829fd925ba7cca03cb95f351 
 aqua_stark4-UsernameToAddress | Synced | 0x0732b8ecec3c4a8d5c8ba31cd10d010c350567cc71b25daa3a1779f77865d8dc 

 Events                    | Status | Dojo Selector                                                      
---------------------------+--------+--------------------------------------------------------------------
 aqua_stark4-PlayerCreated | Synced | 0x01d6cc43e1714e76ad1055201f12420b2218d559aec34307dd39b43e8edaf2b9 

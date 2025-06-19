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
 Synced | 0x037a99da65fb03c5692317efddfeb0ed67dba643ce34e6ccd1179a1894dc5f83 | 0x04c60dc46a8ca8bb47675b7b914053cef769afbf0e340523187336b72bd71d1f 

 Namespaces  | Status | Dojo Selector                                                      
-------------+--------+--------------------------------------------------------------------
 aqua_stark6 | Synced | 0x0152e3c2027de37ace726013f2ed3a0fcbbbd87310e01aafe08d7c1bd633f3df 

 Contracts             | Status | Is Initialized | Dojo Selector                                                      | Contract Address                                                   
-----------------------+--------+----------------+--------------------------------------------------------------------+--------------------------------------------------------------------
 aqua_stark6-AquaStark | Synced | true           | 0x071eeb5c29a4c9ddef2c430334d96fe6514d6b470160617ce35b96153dd9b91c | 0x02434f4936e0659641019359af6803cdd0568c76e3215ce0fa83013f23c779f5 

 Models                        | Status | Dojo Selector                                                      
-------------------------------+--------+--------------------------------------------------------------------
 aqua_stark6-AddressToUsername | Synced | 0x04019d518bfe4a2887bbdfee99f4ee8ba5e12dbc3fac7fcd3c9036df9244dcff 
 aqua_stark6-Aquarium          | Synced | 0x03be2a814a0d8ad7bd7696ec4ed232ad3c46f505a95c5eff10e7766c9cf1e1e1 
 aqua_stark6-AquariumCounter   | Synced | 0x050f369bf8c4b97e938246e4a98792efc2f1f0f194231c12ff89ce3e67fe37c3 
 aqua_stark6-AquariumFishes    | Synced | 0x021cf51ead59b7eb4e1fefba3b8e335f4a8c5fe636d10ce9a616ff1292f87c44 
 aqua_stark6-AquariumOwner     | Synced | 0x0323890a857f4643246188edb68acb9583d7de6cb26af761ece51d49ce3b1c33 
 aqua_stark6-Decoration        | Synced | 0x0057d0d33bf2b46fcdec1ed7821fcac95283498a6ce220bb3edc460a54f5ef08 
 aqua_stark6-DecorationCounter | Synced | 0x06185654d3200142bf759c0fc147e12df26121f0f1eed2d2d4c942d3e7228b6f 
 aqua_stark6-Fish              | Synced | 0x0697e9497f3aded3528dcab53686712ffd2c989af084f4c2db3f0f0876aaebb7 
 aqua_stark6-FishCounter       | Synced | 0x05b8437a44e288aea2d9bb2e0e9c8ea62a8562937d035201d1975e6c01972f1c 
 aqua_stark6-FishOwner         | Synced | 0x05a9b680496ef3e7b1fc172e13b2797c1fd5a59b5de285fe8f9bcce2279db3f3 
 aqua_stark6-Game              | Synced | 0x0799140b7b5b7c98d3585488ec18dbe6a4eb3013fa3c931ef69e75f1d13bd552 
 aqua_stark6-GameCounter       | Synced | 0x06aa44ea4dd4d0618fae74dfdc3d6bebdcf47e4bea1dae0d12491fbede09ef5a 
 aqua_stark6-Player            | Synced | 0x0499adc54a727de06fbdd0e3c981e76d8a6a75638025901b25ccae3632dc734c 
 aqua_stark6-PlayerCounter     | Synced | 0x018f24e26e86de490d8b918d2a224d2e6ee20389c9992ddf979b607cb6bc3f60 
 aqua_stark6-PlayerFish        | Synced | 0x0357bcd01ccadb4df9abb8fde452eeffc28e264098e26ea07a4540b899c6dab5 
 aqua_stark6-PlayerFishes      | Synced | 0x07c72ef37447a82717e9902160d9bfcedf8dcfc3a68959efce0d8d94a513b5f1 
 aqua_stark6-UsernameToAddress | Synced | 0x000ae0040ac6672b0bf576ff85d104a342cf4bfb0887d5b7100e9df17482db5e 

 Events                    | Status | Dojo Selector                                                      
---------------------------+--------+--------------------------------------------------------------------
 aqua_stark6-PlayerCreated | Synced | 0x0569a053aeb4659e36a554f17b798d7f2da25b3ad03fd9d355496c093f4072cd 
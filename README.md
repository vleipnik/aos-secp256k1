# AOS-secp256k1

AOS-secp256k1 combines the ao operating system module and secp256k1 to create an ao custom module that enables ECDSA verifications. It leverages a battle-tested and highly optimized [secp256k1 library](https://github.com/bitcoin-core/secp256k1). Some of this work is inspired by the [AOS-SQLite module](https://github.com/permaweb/aos-sqlite) by @elliotsayes.

AOS-secp256k1 Module - `5JfE3UH56N6-BfVDLZY5FXyffY9STf8vx_ED9aqt9VY`

Run a secp256k1 module with AOS(WASM64)

```sh
aos my-secp256k1 --module=5JfE3UH56N6-BfVDLZY5FXyffY9STf8vx_ED9aqt9VY
```

## Spawn via a process

```lua
Spawn('5JfE3UH56N6-BfVDLZY5FXyffY9STf8vx_ED9aqt9VY', { Data = "Hello secp256k1 Wasm64" })
```

## Examples

```lua
local message = "hello";
local signature_der = "3045022100a71d86190354d64e5b3eb2bd656313422cdf7def69bf3669cdbfd09a9162c96e0220713b81f3440bff0b639d2f29b2c48494b812fa89b754b7b6cdc9eaa8027cf369";
local public_key = "02477ce3b986ab14d123d6c4167b085f4d08c1569963a0201b2ffc7d9d6086d2f3";

local is_valid = verify_signature(message, signature_der, public_key)

print("Message: " .. message)
print("Signature Verification Result: " .. (is_valid and "VALID" or "INVALID"))

```

```lua
local message = "bye";
local signature_der = "3045022100a71d86190354d64e5b3eb2bd656313422cdf7def69bf3669cdbfd09a9162c96e0220713b81f3440bff0b639d2f29b2c48494b812fa89b754b7b6cdc9eaa8027cf369";
local public_key = "02477ce3b986ab14d123d6c4167b085f4d08c1569963a0201b2ffc7d9d6086d2f3";

local is_valid = verify_signature(message, signature_der, public_key)

print("Message: " .. message)
print("Signature Verification Result: " .. (is_valid and "VALID" or "INVALID"))

```

## AO Resources

* https://ao.arweave.dev
* https://cookbook_ao.arweave.dev

---

This project builds the AOS-secp256k1 WASM Binary and Publishes it to Arweave.

## Build Process

1. Fetch the submodules

```sh
git submodule init
git submodule update --remote
cd ao-secp256k1/dev-cli/container
git submodule init
git submodule update --remote
cd ../..
```

2. Build docker image

```sh
cd ao-secp256k1/dev-cli/container
docker build --progress=plain . -t p3rmaw3b/ao --platform linux/arm64
cd ../../..
```

3. Use docker image to compile process.wasm

```sh
cd aos/process
docker run --platform linux/arm64 -v .:/src p3rmaw3b/ao ao-build-module
cd ../..
```

4. Publish Module with tags via arkb

> You will need a funded wallet for this step. You can add Winc tokens for the [Turbo app](https://turbo-topup.com/) to do this. 

```sh
npm install
export WALLET=~/.wallet.json
npm run deploy
```

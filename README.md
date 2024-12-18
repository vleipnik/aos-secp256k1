# AOS-secp256k1

AOS-secp256k1 combines the ao operating system module and secp256k1 to create an ao custom module that enables ECDSA verifications. It leverage a battle-tested and highly optimized [secp256k1 library](https://github.com/bitcoin-core/secp256k1). Some of this work is inpired by the [AOS-SQLite module](https://github.com/permaweb/aos-sqlite) by @elliotsayes.

AOS-SQLite Module - `TBD`

Run a SQLite Database with AOS(WASM64)

```sh
aos my-secp256k1 --module=TBD
```

## Spawn via a process

```lua
Spawn('TBD', { Data = "Hello secp256k1 Wasm64" })
```

## Examples

```lua
local message = "hello";
    local signature_der = "3045022100a71d86190354d64e5b3eb2bd656313422cdf7def69bf3669cdbfd09a9162c96e0220713b81f3440bff0b639d2f29b2c48494b812fa89b754b7b6cdc9eaa8027cf369";
    local public_key = "02477ce3b986ab14d123d6c4167b085f4d08c1569963a0201b2ffc7d9d6086d2f3";

    local is_valid = verify_signature(message, signature_der, public_key)
    
    print("Message: " .. message)
    print("Signature Verification Result: " .. (is_valid and "VALID" or "INVALID"))

    local message = "bye";
    local signature_der = "3045022100a71d86190354d64e5b3eb2bd656313422cdf7def69bf3669cdbfd09a9162c96e0220713b81f3440bff0b639d2f29b2c48494b812fa89b754b7b6cdc9eaa8027cf369";
    local public_key = "02477ce3b986ab14d123d6c4167b085f4d08c1569963a0201b2ffc7d9d6086d2f3";

    local is_valid = verify_signature(message, signature_der, public_key)
    
    print("Message: " .. message)
    print("Signature Verification Result: " .. (is_valid and "VALID" or "INVALID"))

```

```lua
local s = ""
 
for row in db:nrows("SELECT * FROM test") do
  s = s .. row.id .. ": " .. row.content .. "\\n"
end
 
return s
```

## AO Resources

* [AOSqlite Workshop](https://hackmd.io/@ao-docs/rkM1C9m40)

* https://ao.arweave.dev
* https://cookbook_ao.arweave.dev

---

This project builds the AOS-SQLITE WASM Binary and Publishes it to Arweave.

## Build Process

1. Build docker image

```sh
cd container
./build.sh
```

2. Get Latest aos module

```sh
git submodule init
git submodule update --remote
```

3. Use docker image to compile process.wasm

```sh
cd aos/process
docker run -v .:/src p3rmaw3b/ao emcc-lua
```

4. Publish Module with tags via arkb

> You will need a funded wallet for this step 

```sh
export WALLET=~/.wallet.json
npm run deploy
```
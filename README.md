# AOS-secp256k1

AOS-secp256k1 combines the ao operating system module and secp256k1 to create an ao custom module that enables ECDSA verifications. It leverages a battle-tested and highly optimized [secp256k1 library](https://github.com/bitcoin-core/secp256k1). Some of this work is inspired by the [AOS-SQLite module](https://github.com/permaweb/aos-sqlite) by @elliotsayes.

AOS-secp256k1 Module - `IlqppmLdIBssZtmY5TlPwTzFUZLkDEhT7aaqoyCrw3A`

Run a secp256k1 module with AOS(WASM64)

## Spawn a process via `aos` CLI
```sh
aos my-secp256k1 --module=IlqppmLdIBssZtmY5TlPwTzFUZLkDEhT7aaqoyCrw3A
```

## OR spawn a process via `aos` console

```lua
Spawn('IlqppmLdIBssZtmY5TlPwTzFUZLkDEhT7aaqoyCrw3A', { Data = "Hello secp256k1 Wasm64" })
```

## Sample Usage

With the local `sample.lua` file, add event-handling logic to your process via `aos` console:
```lua
.load sample.lua
```

Now you can send sample inputs via messages.

A valid signature example:
```lua
Send({ Target='<your process ID>', Action='VerifySig', Data={ message='hello', signature='3045022100a71d86190354d64e5b3eb2bd656313422cdf7def69bf3669cdbfd09a9162c96e0220713b81f3440bff0b639d2f29b2c48494b812fa89b754b7b6cdc9eaa8027cf369', public_key='02477ce3b986ab14d123d6c4167b085f4d08c1569963a0201b2ffc7d9d6086d2f3' } })
```

An invalid signature example:
```lua
Send({ Target='<your process ID>', Action='VerifySig', Data={ message='bai', signature='3045022100a71d86190354d64e5b3eb2bd656313422cdf7def69bf3669cdbfd09a9162c96e0220713b81f3440bff0b639d2f29b2c48494b812fa89b754b7b6cdc9eaa8027cf369', public_key='02477ce3b986ab14d123d6c4167b085f4d08c1569963a0201b2ffc7d9d6086d2f3' } }
```

Valid JWT examples:
```lua
Send({ Target='<your process ID>', Action='VerifyJwt', Data='eyJhbGciOiJFUzI1NksiLCJ0eXAiOiJKV1QifQ.eyJ2YyI6eyJAY29udGV4dCI6WyJodHRwczovL3d3dy53My5vcmcvMjAxOC9jcmVkZW50aWFscy92MSJdLCJ0eXBlIjpbIlZlcmlmaWFibGVDcmVkZW50aWFsIl0sImNyZWRlbnRpYWxTdWJqZWN0Ijp7InlvdSI6IlJvY2sifX0sInN1YiI6ImRpZDp3ZWI6ZXhhbXBsZS5jb20iLCJuYmYiOjE3MzQwMjgzMjIsImlzcyI6ImRpZDpldGhyOnNlcG9saWE6MHgwMmM2M2VmZTNkYzcwN2Y2ZTNkMzIzZjExZTQwY2YwNzU3OGIyYWI5YWVlMTYzNWU2ZWU2NzZmNmRhMDlmMTU5OGQifQ.VEHlsQ7rF5Z5lDuQPZjSp2Tsd-QM0tSB5SWBmE_jZpobbzDaKg1GPoAtZLBeoWwdNfjTxiyhyY08iYw3mCV4rg' })
```

```lua
Send({ Target='<your process ID>', Action='VerifyJwt', Data='eyJhbGciOiJFUzI1NksiLCJ0eXAiOiJKV1QifQ.eyJ2YyI6eyJAY29udGV4dCI6WyJodHRwczovL3d3dy53My5vcmcvMjAxOC9jcmVkZW50aWFscy92MSJdLCJ0eXBlIjpbIlZlcmlmaWFibGVDcmVkZW50aWFsIl0sImNyZWRlbnRpYWxTdWJqZWN0Ijp7InlvdSI6IlJvY2sifX0sInN1YiI6ImRpZDp3ZWI6ZXhhbXBsZS5jb20iLCJuYmYiOjE3MzQwMjg3ODAsImlzcyI6ImRpZDpldGhyOnNlcG9saWE6MHgwMmM2M2VmZTNkYzcwN2Y2ZTNkMzIzZjExZTQwY2YwNzU3OGIyYWI5YWVlMTYzNWU2ZWU2NzZmNmRhMDlmMTU5OGQifQ.VEHlsQ7rF5Z5lDuQPZjSp2Tsd-QM0tSB5SWBmE_jZppghPpee_pZyzigqsUCeWV9J0rt8SI2oS7uhjm1JaLrww' })
```

An invalid JWT example:
```lua
Send({ Target='<your process ID>', Action='VerifyJwt', Data='eyJhbGciOiJFUzI1NksiLCJ0eXAiOiJKV1QifQ.eyJ2YyI6eyJAY29udGV4dCI6WyJodHRwczovL3d3dy53My5vcmcvMjAxOC9jcmVkZW50aWFscy92MSJdLCJ0eXBlIjpbIlZlcmlmaWFibGVDcmVkZW50aWFsIl0sImNyZWRlbnRpYWxTdWJqZWN0Ijp7InlvdSI6IlJvY2tzb3JzIn19LCJzdWIiOiJkaWQ6d2ViOmV4YW1wbGUuY29tIiwibmJmIjoxNzM0MDI4MzIyLCJpc3MiOiJkaWQ6ZXRocjpzZXBvbGlhOjB4MDJjNjNlZmUzZGM3MDdmNmUzZDMyM2YxMWU0MGNmMDc1NzhiMmFiOWFlZTE2MzVlNmVlNjc2ZjZkYTA5ZjE1OThkIn0=.VEHlsQ7rF5Z5lDuQPZjSp2Tsd-QM0tSB5SWBmE_jZpobbzDaKg1GPoAtZLBeoWwdNfjTxiyhyY08iYw3mCV4rg' })
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
cd ../../..
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

4. Publish Module with tags via Turbo

> You will need a funded wallet for this step. You can add Winc tokens for the [Turbo app](https://turbo-topup.com/) to do this. 

```sh
npm install
export WALLET=~/.wallet.json
npm run deploy
```

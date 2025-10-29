# 3Dino - Building

> **Note:** on Windows, use WSL.

## Building the app

### Setup build environment

1. Install [Node.js](https://nodejs.org/en/download)

1. Install [Nwlink](https://www.npmjs.com/package/nwlink/v/0.0.12):

   ```sh
   npm install -g nwlink
   ```

1. Install [Rust](https://rust-lang.org/tools/install/)

1. Install [Just](https://just.systems/):

   ```sh
   cargo install just
   ```


### Objects

To convert a `.obj` file to `.pbj`, run:
```sh
just obj [file location] [object name]

# Example usage:
just obj build/obj/Mesh_Beagle.obj dog
```
This creates a `.pbj` file in `/target/obj/`.


### NumWorks calculator

Building for the NumWorks calculator requires adding its Rust target:
```sh
rustup target add thumbv7em-none-eabihf
```

To build the app, run:
```sh
just build
```
This creates a binary (`.nwa`) file at `/target/thumbv7em-none-eabihf/release/nw_3dino`.

To load the app to the calculator, run:
```sh
just load [object name]

# Example usage:
just load dog
```


### Simulator

To build the app for the simulator, run:
```sh
just nwb-build
```
This creates a binary (`.nwb`) file at `/target/[your Rust host]/release/libnw_3dino_sim`, with a file extension according to your operating system.

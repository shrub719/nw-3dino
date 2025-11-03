<h1 align="center">
    <img src="assets/repo_icon.png" alt="3Dino logo" height="100px"> 
    <br />
    3Dino
</h1>

A 3D model viewer for NumWorks Epsilon.

> This is a fork of [NumWorks 3D Grapher](https://github.com/shrub719/nw-3d-grapher).


## Installation

### NumWorks calculator

1. Go to the [latest release](https://github.com/shrub719/nw-3dino/releases/latest)

1. Download `nw_3dino.nwa`  

1. Get the PBJ file of the 3D model you want (such as `dino.pbj`)
   > **Note:** See [PBJ files](#pbj-files) for instructions on making your own PBJ files.

1. Connect to your calculator by USB

1. Go to the [Numworks Installer](https://my.numworks.com/apps) and click **Connect** (make sure your browser has WebUSB capability)

1. Upload `nw_3dino.nwa`

1. Click **Select a data file**

1. Upload the PBJ file

1. Press **Install**

### Simulator

1. Go to the [latest release](https://github.com/shrub719/fun-numworks-apps/releases/latest)

1. Download the `.nwb` file for your operating system
   > **Note:** on Windows, use WSL.  

1. Get the simulator for your operating system
   > **Note:** NumWorks does not allow simulators to be redistributed, so you will have to [patch and build the simulator yourself](build/BUILDING.md#building-the-simulator).

1. Get the PBJ file of the 3D model you want (such as `dino.pbj`)
   > **Note:** See [PBJ files](#pbj-files) for instructions on making your own PBJ files.

1. Run the `.nwb` file with the simulator in your terminal:
   ```sh
   # linux/wsl
   ./epsilon_linux.bin --nwb ./nw_3dino_linux.nwb --nwb-external-data ./dino.pbj

   # macos
   ./epsilon_macos.app/Contents/MacOS/Epsilon --nwb ./nw_3dino_macos.nwb --nwb-external-data ./dino.pbj
   ```

### PBJ files

You can convert `.obj` files to `.pbj` files with the PyPi library `nw-3dino-convert`. 

1. Install it with:
   ```sh
   pip install nw-3dino-convert
   ```

1. Then, to convert a file (e.g. `meshes/dino.obj`), run:
   ```sh
   nw-3dino-convert meshes/dino.obj
   ```


## Usage

### NumWorks calculator

**Rotate:** D-pad
**Tilt:** Shift, Alpha
**Scale:** Plus, Minus
**Toggle shading:** OK

### Simulator

**Rotate:** WASD, Arrow keys
**Tilt:** Q, E, Shift, Ctrl
**Scale:** R, F, Plus, Minus
**Toggle shading:** OK

> **Note:** On-screen calculator controls work as well.


## Building

See [BUILDING.md](build/BUILDING.md) for instructions on how to build the app or pack objects.


## Licensing and credits

As this repo contains part of my A level Computer Science coursework, it is under exam regulations. Therefore:
- **Until August 14 2026** all rights are reserved by me. No permission is granted to copy, use, modify, or distribute any part of this project during this period.
- **After August 15 2026**, the project is released under the [MIT License](LICENSE).

Dinosaur model in `obj/dino.obj` and `dino.pbj`: Substitute from Pokémon Stadium 2 via [The Models Resource](https://models.spriters-resource.com/nintendo_64/pokemonstadium2/asset/312410/).

This project is a third-party app and is not affiliated with NumWorks. NumWorks is a registered trademark of NumWorks SAS.

Thanks to:
   - [yannis300307](https://github.com/yannis30030) for parts of the extended EADK
   - [fricht](https://github.com/fricht) for the external data EADK additions

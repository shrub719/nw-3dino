<h1 align="center">
    <img src="assets/repo_icon.png" alt="3Dino logo" height="100px"> 
    <br />
    3Dino
</h1>

A 3D model viewer for NumWorks Epsilon.


## Installation

### NumWorks calculator

The app supports importing 3D models as `.pbj`.

1. Go to the [latest release](https://github.com/shrub719/nw-3dino/releases/latest)

1. Download `nw_3dino.nwa`  
   *Optionally, download the example `dino.pbj`*

1. Connect to your calculator by USB

1. Go to the [Numworks Installer](https://my.numworks.com/apps) and click **Connect** (make sure your browser has WebUSB capability)

1. Upload `nw_3dino.nwa`

1. Click **Select a data file**

1. Upload the `.pbj` file of the 3D model you want

1. Press **Install**

### Simulator

1. Go to the [latest release](https://github.com/shrub719/fun-numworks-apps/releases/latest)

1. Download the `.nwb` file for your operating system

    > **Note:** on Windows, use WSL.

1. Get the simulator for your operating system
   > **Note:** NumWorks does not allow simulators to be redistributed, so you will have to [patch and build the simulator yourself](build/BUILDING.md#building-the-simulator).

1. Run the `.nwb` file with the simulator in your terminal:
   <!-- TODO -->


## Usage

### NumWorks calculator

<!-- TODO: controls, features -->

### Simulator

<!-- TODO: remapped sim controls -->


## Building

See [BUILDING.md](build/BUILDING.md) for instructions on how to build the app or the simulator.


## Licensing and credits

Dog model in `obj/dino.obj` and `dino.pbj`: [TODO](TODO) by [TODO](TODO) Via Poly Pizza.

This project is a third-party app and is not affiliated with NumWorks. NumWorks is a registered trademark of NumWorks SAS.

Thanks to:
   - [yannis300307](https://github.com/yannis30030) for parts of the extended EADK
   - [fricht](https://github.com/fricht) for the external data EADK additions

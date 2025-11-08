current_target := `rustc -Vv | grep host | awk '{print $2}'`

# ===== OBJECTS =====

# creates .pbj in target/obj from .obj source file
# input_file contains .obj file location (e.g. obj/meshes/dino.obj)
# obj_name contains .pbj file name (e.g. dino)
# DEPRECATED: use nw-3dino-convert instead
obj input_file obj_name:
    mkdir -p target/obj
    python3 build/obj/pack_obj.py {{input_file}} {{obj_name}}

# automatically creates .pbj from obj/meshes - obj_name is the name of the .pbj file
dev-obj obj_name:
    just obj build/obj/meshes/{{obj_name}}.obj {{obj_name}}


# ===== DEVICE =====

# builds release profile
build:
    cargo build --release --bin nw_3dino --target=thumbv7em-none-eabihf

# builds dev profile
[default]
dev:
    cargo build --bin nw_3dino --target=thumbv7em-none-eabihf

# loads app to calculator - obj_name is the name of the .pbj file
load obj_name="dino":
    cargo run --release --bin nw_3dino --target=thumbv7em-none-eabihf -- -d target/obj/{{obj_name}}.pbj

# automatically creates .pbj from obj/meshes before loading to calculator - obj_name is the name of the .pbj file
dev-load obj_name="dino":
    just dev-obj {{obj_name}}
    cargo run --bin nw_3dino --target=thumbv7em-none-eabihf  -- -d target/obj/{{obj_name}}.pbj


# ===== SIMULATOR =====

# builds release profile for simulator
nwb-build:
    cargo build --release --lib --target={{current_target}}

# builds dev profile for simulator
nwb-dev:
    cargo build --lib --target={{current_target}}

# runs dev profile on simulator
[macos]
run obj_name="dino": nwb-dev
    just dev-obj {{obj_name}}
    ./sim/epsilon.app/Contents/MacOS/Epsilon --nwb ./target/{{current_target}}/debug/libnw_3dino_sim.dylib --nwb-external-data target/obj/{{obj_name}}.pbj
[linux]
run obj_name="dino": nwb-dev
    just dev-obj {{obj_name}}
    ./sim/epsilon.bin --nwb ./target/{{current_target}}/debug/libnw_3dino_sim.so --nwb-external-data target/obj/{{obj_name}}.pbj

# ===== SIMULATOR: LEGACY =====

# remaps sim inputs - sim_dir is the directory containing epsilon
remap-sim sim_dir="epsilon_simulator":
    python3 build/sim/remap_inputs.py {{sim_dir}}

# sets up build environment for epsilon simulator
setup-sim:
    -git clone https://github.com/numworks/epsilon epsilon_simulator -b version-20
    cd epsilon_simulator && build/setup.sh --only-simulator
    just remap-sim

# builds epsilon simulator
build-sim jobs="8": remap-sim
    cd epsilon_simulator && make PLATFORM=simulator -j {{jobs}}

# run app on simulator - sim_dir is the directory containing epsilon
[macos]
nwb-run obj_name="dino" sim_dir="epsilon_simulator": nwb-build
    ./{{sim_dir}}/output/release/simulator/macos/epsilon.app/Contents/MacOS/Epsilon --nwb ./target/{{current_target}}/release/libnw_3dino_sim.dylib --nwb-external-data target/obj/{{obj_name}}.pbj
[linux]
nwb-run obj_name="dino" sim_dir="epsilon_simulator": nwb-build
    ./{{sim_dir}}/output/release/simulator/linux/epsilon.bin --nwb ./target/{{current_target}}/release/libnw_3dino_sim.so --nwb-external-data target/obj/{{obj_name}}.pbj

# run dev profile on simulator
[macos]
nwb-dev-run obj_name="dino": nwb-dev
    just dev-obj {{obj_name}}
    ./epsilon_simulator/output/release/simulator/macos/epsilon.app/Contents/MacOS/Epsilon --nwb ./target/{{current_target}}/debug/libnw_3dino_sim.dylib --nwb-external-data target/obj/{{obj_name}}.pbj
[linux]
nwb-dev-run obj_name="dino": nwb-dev
    just dev-obj {{obj_name}}
    ./epsilon_simulator/output/release/simulator/linux/epsilon.bin --nwb ./target/{{current_target}}/debug/libnw_3dino_sim.so --nwb-external-data target/obj/{{obj_name}}.pbj


# ===== UTILS =====

clean:
    cargo clean

clean-sim:
    cd ./epsilon_simulator && make clean

clean-all: clean clean-sim

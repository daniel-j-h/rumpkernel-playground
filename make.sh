#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

readonly toolchain=${1:-'~/rumpkernel-playground/rumprun/rumprun/rumprun-x86_64/share/x86_64-rumprun-netbsd-toolchain.cmake'}
readonly platform=${2:-'hw_generic'}


# Compile and link app
mkdir -p build
pushd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=${toolchain}
cmake --build .
popd

# Bake a Unikernel pulling in components from Anykernel
env RUMPRUN_WARNING_STFU='please' rumprun-bake ${platform} build/app.bin build/app

# Strip binary to reduce its size
x86_64-rumprun-netbsd-strip --strip-unneeded build/app.bin

# Generate a volume we later mount, containing all data the app needs
genisoimage -r -quiet -o build/volume.iso test.txt

# Start the Unikernel in Qemu and mount the volume
env RUMPRUN_WARNING_STFU='please' rumprun kvm -b build/volume.iso,/data -i build/app.bin '/data/test.txt'

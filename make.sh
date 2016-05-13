#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

mkdir -p build
pushd build
cmake .. -DCMAKE_TOOLCHAIN_FILE='~/rumpkernel-playground/rumprun/rumprun/rumprun-x86_64/share/x86_64-rumprun-netbsd-toolchain.cmake' -DRUMPRUN_PLATFORM='hw_generic'
env RUMPRUN_WARNING_STFU='please' cmake --build .
popd

x86_64-rumprun-netbsd-strip --strip-unneeded build/app.bin

genisoimage -r -quiet -o build/volume.iso test.txt

env RUMPRUN_WARNING_STFU='please' rumprun kvm -b build/volume.iso,/data -i build/app.bin '/data/test.txt'

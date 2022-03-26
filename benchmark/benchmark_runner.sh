#!/bin/bash

set -euo pipefail

EXECUTABLE="$1"

echo -e -n "openblas,\t\t"
./"$EXECUTABLE"

echo -e -n "simdleblas,\t\t"
LD_PRELOAD=build/simdle/libblas.so ./"$EXECUTABLE"

echo -e -n "mkl,       \t\t"
LD_PRELOAD=/usr/lib/x86_64-linux-gnu/mkl/libblas.so ./"$EXECUTABLE"
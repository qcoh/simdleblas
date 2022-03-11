#!/bin/bash

set -euo pipefail

EXECUTABLE="$1"

echo "With OpenBLAS:"
./"$EXECUTABLE"

echo "With simdleblas:"
LD_PRELOAD=build/simdle/libblas.so ./"$EXECUTABLE"

echo "With mkl:"
LD_PRELOAD=/usr/lib/x86_64-linux-gnu/mkl/libblas.so ./"$EXECUTABLE"
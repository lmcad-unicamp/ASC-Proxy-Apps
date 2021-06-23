#!/bin/bash
cd ../Kripke
mkdir build
cd build
cmake -DCMAKE_CXX_COMPILER=mpic++ ..
make -j 2
cd ../../LULESH
make
cd ../Quicksilver/src
make

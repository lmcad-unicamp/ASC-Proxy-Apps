#!/bin/bash
HOSTFILE=$PWD/hostfile
DATASET=$PWD/$1
NAME=$(date +"%m-%d-%y-%T")
mkdir $DATASET
cd ..
if [[ $2 -eq 1 ]]; then
  kripke_a_app="./build/bin/kripke.exe --niter 100 --zones 16,16,16 --procs 1,1,1"
  kripke_b_app="./build/bin/kripke.exe --niter 100 --zones 26,26,26 --procs 1,1,1"
  kripke_c_app="./build/bin/kripke.exe --niter 100 --zones 38,38,38 --procs 1,1,1"
elif [[ $2 -eq 2 ]]; then
  kripke_a_app="./build/bin/kripke.exe --niter 100 --zones 16,16,16 --procs 2,1,1"
  kripke_b_app="./build/bin/kripke.exe --niter 100 --zones 26,26,26 --procs 2,1,1"
  kripke_c_app="./build/bin/kripke.exe --niter 100 --zones 38,38,38 --procs 2,1,1"
elif [[ $2 -eq 4 ]]; then
  kripke_a_app="./build/bin/kripke.exe --niter 100 --zones 16,16,16 --procs 2,2,1"
  kripke_b_app="./build/bin/kripke.exe --niter 100 --zones 26,26,26 --procs 2,2,1"
  kripke_c_app="./build/bin/kripke.exe --niter 100 --zones 38,38,38 --procs 2,2,1"
elif [[ $2 -eq 8 ]]; then
  kripke_a_app="./build/bin/kripke.exe --niter 100 --zones 16,16,16 --procs 4,2,1"
  kripke_b_app="./build/bin/kripke.exe --niter 100 --zones 26,26,26 --procs 4,2,1"
  kripke_c_app="./build/bin/kripke.exe --niter 100 --zones 38,38,38 --procs 4,2,1"
elif [[ $2 -eq 16 ]]; then
  kripke_a_app="./build/bin/kripke.exe --niter 100 --zones 16,16,16 --procs 4,4,1"
  kripke_b_app="./build/bin/kripke.exe --niter 100 --zones 26,26,26 --procs 4,4,1"
  kripke_c_app="./build/bin/kripke.exe --niter 100 --zones 38,38,38 --procs 4,4,1"
elif [[ $2 -eq 32 ]]; then
  kripke_a_app="./build/bin/kripke.exe --niter 100 --zones 16,16,16 --procs 8,4,1"
  kripke_b_app="./build/bin/kripke.exe --niter 100 --zones 26,26,26 --procs 8,4,1"
  kripke_c_app="./build/bin/kripke.exe --niter 100 --zones 38,38,38 --procs 8,4,1"
fi
qs_a_app="./src/qs --nSteps 100 --nParticles 100000"
qs_b_app="./src/qs --nSteps 100 --nParticles 500000"
qs_c_app="./src/qs --nSteps 100 --nParticles 1000000"
lulesh_a_app="./lulesh2.0 -i 1000 -s 30"
lulesh_b_app="./lulesh2.0 -i 1000 -s 60"
lulesh_c_app="./lulesh2.0 -i 1000 -s 120"
# Kripke
cd Kripke
mpirun -n $2 --hostfile $HOSTFILE $kripke_a_app > $DATASET/$NAME-kripke-A.out 2> $DATASET/$NAME-kripke-A.err
mpirun -n $2 --hostfile $HOSTFILE $kripke_b_app > $DATASET/$NAME-kripke-B.out 2> $DATASET/$NAME-kripke-B.err
mpirun -n $2 --hostfile $HOSTFILE $kripke_c_app > $DATASET/$NAME-kripke-C.out 2> $DATASET/$NAME-kripke-C.err
cd ..
# Quicksilver
cd Quicksilver
mpirun -n $2 --hostfile $HOSTFILE $qs_a_app > $DATASET/$NAME-Quicksilver-A.out 2> $DATASET/$NAME-Quicksilver-A.err
mpirun -n $2 --hostfile $HOSTFILE $qs_b_app > $DATASET/$NAME-Quicksilver-B.out 2> $DATASET/$NAME-Quicksilver-B.err
mpirun -n $2 --hostfile $HOSTFILE $qs_c_app > $DATASET/$NAME-Quicksilver-C.out 2> $DATASET/$NAME-Quicksilver-C.err
cd ..
# LULESH
cd LULESH
mpirun -n $2 --hostfile $HOSTFILE $lulesh_a_app > $DATASET/$NAME-LULESH-A.out 2> $DATASET/$NAME-LULESH-A.err
mpirun -n $2 --hostfile $HOSTFILE $lulesh_b_app > $DATASET/$NAME-LULESH-B.out 2> $DATASET/$NAME-LULESH-B.err
mpirun -n $2 --hostfile $HOSTFILE $lulesh_c_app > $DATASET/$NAME-LULESH-C.out 2> $DATASET/$NAME-LULESH-C.err
cd ..

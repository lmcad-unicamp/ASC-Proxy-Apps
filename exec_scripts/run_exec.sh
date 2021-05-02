DATASET=exp_results

rm -rf $DATASET
mkdir $DATASET

kripke_app=./build/bin/kripke.exe --niter 100
qs_app=./src/qs --nSteps 100
lulesh_app=./lulesh2.0 -i 100

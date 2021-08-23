export PETSC_DIR=${PREFIX}

# System report 
bash DAMASK_prerequisites.sh
cat system_report.txt

# Build grid solver
mkdir build_grid
cd build_grid 
cmake -DDAMASK_SOLVER="grid" -DCMAKE_INSTALL_PREFIX="${PREFIX}" ..
make -j$CPU_COUNT install
cd ..

# Build mesh solver
mkdir build_mesh
cd build_mesh
cmake -DDAMASK_SOLVER="mesh" -DCMAKE_INSTALL_PREFIX="${PREFIX}" ..
make -j$CPU_COUNT install
cd ..

# Python Installation 
cd python
cp ../VERSION .
python -m pip install . --no-deps -vv
cp VERSION ${STDLIB_DIR}/site-packages/damask/VERSION
cd ..

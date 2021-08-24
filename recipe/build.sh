export PETSC_DIR=${PREFIX}

# System report 
bash DAMASK_prerequisites.sh
cat system_report.txt

# Build grid solver
cmake -S . -B build-grid -DDAMASK_SOLVER=grid
cmake --build build-grid --target install

# Build mesh solver
mkdir build_mesh
cd build_mesh
cmake -DDAMASK_SOLVER="mesh" -DCMAKE_INSTALL_PREFIX="${PREFIX}" ..
make -j$CPU_COUNT install
cd ..

# Python Installation 
cd python
pip install . -vv --use-feature=in-tree-build
cd ..

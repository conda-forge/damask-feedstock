export PETSC_DIR=${PREFIX}

# System report 
bash DAMASK_prerequisites.sh
cat system_report.txt

# Build grid solver
cmake -S . -B build-grid -DDAMASK_SOLVER=grid -DCMAKE_INSTALL_PREFIX=${PREFIX}
cmake --build build-grid --target install

# Build mesh solver
cmake -S . -B build-mesh -DDAMASK_SOLVER=mesh -DCMAKE_INSTALL_PREFIX=${PREFIX}
cmake --build build-mesh --target install

# Python Installation 
cd python
$PYTHON setup.py install
cd ..

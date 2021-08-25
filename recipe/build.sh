export PETSC_DIR=${PREFIX}

# System report 
bash DAMASK_prerequisites.sh
cat system_report.txt

# Build grid solver
cmake -B build-grid -DDAMASK_SOLVER=grid -DCMAKE_INSTALL_PREFIX=${PREFIX}
cmake --build build-grid --target install

# Build mesh solver
cmake -B build-mesh -DDAMASK_SOLVER=mesh -DCMAKE_INSTALL_PREFIX=${PREFIX}
cmake --build build-mesh --target install

# Python Installation 
cd python
cp ../VERSION .
python -m pip install . --no-deps -vv
cp VERSION ${STDLIB_DIR}/site-packages/damask/VERSION
cd ..

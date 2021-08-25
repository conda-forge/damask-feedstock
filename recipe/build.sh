# System report 
PETSC_DIR=${PREFIX} bash DAMASK_prerequisites.sh
cat system_report.txt

# Grid solver
PETSC_DIR=${PREFIX} cmake -B build-grid -DDAMASK_SOLVER=grid -DCMAKE_INSTALL_PREFIX=${PREFIX}
cmake --build build-grid --target install

# Mesh solver
PETSC_DIR=${PREFIX} cmake -B build-mesh -DDAMASK_SOLVER=mesh -DCMAKE_INSTALL_PREFIX=${PREFIX}
cmake --build build-mesh --target install

# Pre- and post-processing tools
$PYTHON python/setup.py install

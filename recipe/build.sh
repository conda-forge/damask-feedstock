export PETSC_DIR=${PREFIX}
export FFLAGS="${FFLAGS} -lhdf5_fortran -lhdf5 -lfftw3_mpi -lfftw3"

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
mkdir -p ${STDLIB_DIR}/damask
cp VERSION ${STDLIB_DIR}/damask/VERSION

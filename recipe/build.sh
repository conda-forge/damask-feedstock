export PETSC_DIR=${PREFIX}

# System report 
bash DAMASK_prerequisites.sh
cat system_report.txt

# Build grid solver
mkdir build_grid
cd build_grid 
cmake -DDAMASK_SOLVER="grid" -DCMAKE_INSTALL_PREFIX="${PREFIX}" -DLINKER_FLAGS="${LDFLAGS" ..
make -j$CPU_COUNT install
cd ..

# Build mesh solver
mkdir build_mesh
cd build_mesh
cmake -DDAMASK_SOLVER="mesh" -DCMAKE_INSTALL_PREFIX="${PREFIX}" -DLINKER_FLAGS="${LDFLAGS" ..
make -j$CPU_COUNT install
cd ..

# Python Installation 
cd python
cp ../VERSION .
python -m pip install . --no-deps -vv
cp VERSION ${STDLIB_DIR}/site-packages/damask/VERSION
cd ..

# Pre-processing tools 
for f in $(ls processing/pre/*); do
     n=$(basename $f)
     cp -r $f ${PREFIX}/bin/${n%.*};
 done
 for f in $(ls processing/post/*); do
     n=$(basename $f)
     cp -r $f ${PREFIX}/bin/${n%.*};
 done

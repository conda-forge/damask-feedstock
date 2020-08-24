export PETSC_DIR=${PREFIX}
export FFLAGS="${FFLAGS} -lhdf5_fortran -lhdf5 -lfftw3_mpi -lfftw3"

# System report 
bash DAMASK_prerequisites.sh
cat system_report.txt

# Python Installation 
cp -r python/damask ${STDLIB_DIR}
cp VERSION ${PREFIX}/lib/VERSION
for f in $(ls processing/misc/*); do
    n=$(basename $f)
    cp -r $f ${PREFIX}/bin/${n%.*};
done
for f in $(ls processing/pre/*); do
    n=$(basename $f)
    cp -r $f ${PREFIX}/bin/${n%.*};
done
for f in $(ls processing/post/*); do
    n=$(basename $f)
    cp -r $f ${PREFIX}/bin/${n%.*};
done

# Build Damask
mkdir build_grid
cd build_grid 
cmake -DDAMASK_SOLVER="grid" -DCMAKE_INSTALL_PREFIX="${PREFIX}/bin" ..
make -j$CPU_COUNT install
cp src/DAMASK_grid ${PREFIX}/bin
cd ..

mkdir build_mesh
cd build_mesh
cmake -DDAMASK_SOLVER="mesh" -DCMAKE_INSTALL_PREFIX="${PREFIX}/bin" ..
make -j$CPU_COUNT install
cp src/DAMASK_mesh ${PREFIX}/bin
cd ..

cd python
pip install .

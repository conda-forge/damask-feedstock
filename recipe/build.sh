export PETSC_DIR=${PREFIX}
export FFLAGS="${FFLAGS} -lhdf5_fortran -lhdf5 -lfftw3_mpi -lfftw3"

# System report 
bash DAMASK_prerequisites.sh
cat system_report.txt

# Python Installation 
cp -r python/damask ${STDLIB_DIR}
cp VERSION ${PREFIX}/lib/VERSION
cp -r processing ${STDLIB_DIR}/damask
rm ${STDLIB_DIR}/damask/processing/pre/geom_check.sh
cp processing/pre/geom_check.sh ${PREFIX}/bin
rm ${STDLIB_DIR}/damask/processing/pre/seeds_check.sh
cp processing/pre/seeds_check.sh ${PREFIX}/bin

# Build Damask
mkdir build
cd build 
cmake -DDAMASK_SOLVER="SPECTRAL" -DCMAKE_INSTALL_PREFIX="${PREFIX}/bin" ..
make -j$CPU_COUNT install
cp src/DAMASK_spectral ${PREFIX}/bin

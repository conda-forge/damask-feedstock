if [[ $CONDA_BUILD_CROSS_COMPILATION = '1' ]]; then sed -i.bak -e 's/ -mtune=native//g' cmake/Compiler-GNU.cmake; fi
export OPAL_PREFIX=${PREFIX}
PETSC_DIR=${PREFIX} cmake -B build-grid -DDAMASK_SOLVER=grid -DCMAKE_INSTALL_PREFIX=${PREFIX} ${CMAKE_ARGS}
cmake --build build-grid --target install

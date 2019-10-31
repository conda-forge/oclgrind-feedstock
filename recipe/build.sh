#!/bin/bash

mkdir build
cd build

# avoid linking to libLLVM in build prefix
rm -vf "$BUILD_PREFIX"/lib/libLLVM*.a
rm -vf "$BUILD_PREFIX"/lib/libclang*.a

cmake .. \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=${PREFIX} \
      -DCMAKE_PREFIX_PATH=${PREFIX} \
      -DLIBDIR_SUFFIX="" \
      -DLLVM_DIR=${PREFIX}/lib/cmake/llvm

make -j${CPU_COUNT} VERBOSE=1
make install
make test

mkdir -p ${PREFIX}/etc/OpenCL/vendors
cp oclgrind.icd ${PREFIX}/etc/OpenCL/vendors/

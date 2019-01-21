#!/bin/bash

mkdir build
cd build

if [ "$(uname)" == "Linux" ]
then
   export LDFLAGS="$LDFLAGS -Wl,-rpath-link,${PREFIX}/lib"
fi

cmake .. \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX=${PREFIX} \
      -DCMAKE_PREFIX_PATH=${PREFIX} \
      -DLIBDIR_SUFFIX="" \
      -DLLVM_DIR=${PREFIX}/lib/cmake/llvm

make -j${CPU_COUNT}
make install
make test

mkdir -p ${PREFIX}/etc/OpenCL/vendors
cp oclgrind.icd ${PREFIX}/etc/OpenCL/vendors/

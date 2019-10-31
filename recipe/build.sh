#!/bin/bash

mkdir build
cd build

if [[ "$target_platform" == "linux-ppc64le" ]]; then
  CXXFLAGS=$(echo "${CXXFLAGS}" | sed "s/-std=c++17/-std=gnu++14/g")
  sed -i.bak "s/-std=c++11//g" CMakeLists.txt
fi

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

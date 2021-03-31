mkdir build
cd build

set "CC=cl.exe"
set "CXX=cl.exe"

cmake -G "Ninja" .. ^
      -DCMAKE_BUILD_TYPE=Release ^
      -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
      -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
      -DLLVM_DIR=%LIBRARY_PREFIX%/lib/cmake/llvm

ninja -j%CPU_COUNT%
ninja install
ctest

rmdir -Rf %LIBRARY_INC%\CL
move %LIBRARY_LIB%\*.dll %LIBRARY_BIN%\

mkdir %LIBRARY_PREFIX%\etc\OpenCL\vendors
echo %LIBRARY_BIN%\oclgrind-rt-icd.dll> %LIBRARY_PREFIX%\etc\OpenCL\vendors\oclgrind.icd
type %LIBRARY_PREFIX%\etc\OpenCL\vendors\oclgrind.icd

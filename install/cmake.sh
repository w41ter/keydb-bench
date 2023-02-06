#!/bin/bash

# This script install the cmake binary.
wget https://github.com/Kitware/CMake/releases/download/v3.25.1/cmake-3.25.1-linux-x86_64.tar.gz
tar zxvf cmake-3.25.1-linux-x86_64.tar.gz
mv cmake-3.25.1-linux-x86_64 /usr/share/
ln -s  /usr/share/cmake-3.25.1-linux-x86_64/bin/cmake /usr/bin/cmake
cmake --version

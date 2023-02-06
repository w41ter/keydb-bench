#!/bin/bash

# This script will build and package kvrocks.

if [ ! -d incubator-kvrocks ]; then
    echo "clone kvrocks"
    git clone https://github.com/apache/incubator-kvrocks.git
fi

cd incubator-kvrocks
./x.py build -j`nproc`
cd build && tar zcf kvrocks.tar.gz kvrocks && cp kvrocks.tar.gz /var/www/html/

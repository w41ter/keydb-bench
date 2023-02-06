#!/bin/bash

# This script will build and package keydb.

if [ ! -d KeyDB ]; then
    echo "clone keydb"
    git clone https://github.com/Snapchat/KeyDB.git && cd KeyDB && \
        git submodule init && \
        git submodule update
fi

cd $(pwd)/KeyDB
make -j`nproc` ENABLE_FLASH=yes
cd src && tar zcf keydb.tar.gz keydb-server && cp keydb.tar.gz /var/www/html

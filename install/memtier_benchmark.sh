#!/bin/bash

apt-get install -y libpcre3-dev libevent-dev pkg-config zlib1g-dev libssl-dev
git clone https://github.com/RedisLabs/memtier_benchmark.git
cd memtier_benchmark
wget https://github.com/RedisLabs/memtier_benchmark/pull/166.patch
git am 166.patch
autoreconf -ivf
./configure
make -j`nproc`
sudo make install

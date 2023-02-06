#!/bin/bash

git clone https://github.com/redis/redis.git
cd redis
git checkout 7.0.8
make BUILD_TLS=yes -j`nproc` && make install

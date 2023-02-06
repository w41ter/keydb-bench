#!/bin/bash

git clone https://github.com/oliver006/redis_exporter.git
cd redis_exporter
go build .
./redis_exporter --version


#!/bin/bash

git clone https://github.com/KvrocksLabs/kvrocks_exporter.git
cd kvrocks_exporter
go build .
./kvrocks_exporter --version

pkill kvrocks_exporter
setsid ./kvrocks_exporter >/var/log/kvrocks_exporter.log 2>&1 &

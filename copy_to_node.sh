#!/bin/bash

# This script will copies all scripts and files to the private nodes.

source config.sh

function upload() {
    local ip=$1
    local path=$2

    scp -r ${path} ${USER}@${ip}:~
}

for ip in ${HOSTS_PRIVATE[@]}; do
    upload $ip config.sh
    upload $ip setup_node.sh
    upload $ip install
    upload $ip tools
    upload $ip cluster
    upload $ip kvrocks_exporter/kvrocks_exporter
done

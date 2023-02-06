#!/bin/bash

source config.sh

function upload() {
    local path=$1

    scp -r ${path} ${USER}@${HOST_CENTRAL}:~
}

upload config.sh
upload setup_node.sh
upload setup_central.sh
upload copy_to_node.sh
upload install
upload tools
upload cluster
upload bench

# upload bench


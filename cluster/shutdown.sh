#!/bin/bash

source config.sh
source cluster/config.sh

for node in ${HOST_KEYDB_NODES[@]}; do
    ssh ${USER}@${node} "bash cluster/node/shutdown.sh" </dev/null &
done
wait

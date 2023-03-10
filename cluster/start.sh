#!/bin/bash

source config.sh
source cluster/config.sh

for node in ${HOST_KEYDB_NODES[@]}; do
    ssh ${USER}@${node} "systemctl start keydb-${KEYDB_PORT}.service" </dev/null
done

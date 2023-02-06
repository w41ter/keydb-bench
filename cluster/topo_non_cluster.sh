#!/bin/bash

source config.sh
source cluster/config.sh

echo "Master node is ${INIT_NODE}"
for host in ${HOST_KEYDB_NODES[@]}; do
    if [[ $host == ${INIT_NODE} ]]; then
        redis-cli -p ${KEYDB_PORT} -h ${host} REPLICAOF no one
    else
        redis-cli -p ${KEYDB_PORT} -h ${host} REPLICAOF ${INIT_NODE} ${KEYDB_PORT}
    fi
done

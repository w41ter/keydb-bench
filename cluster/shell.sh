#!/bin/bash

source config.sh
source cluster/config.sh

if [[ "${CLUSTER_MODE}" == "yes" ]]; then
    redis-cli -c -h ${HOST_KEYDB_1} -p ${KEYDB_PORT}
else
    redis-cli -h ${HOST_KEYDB_1} -p ${KEYDB_PORT}
fi

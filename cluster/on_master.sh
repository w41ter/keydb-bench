#!/bin/bash

source config.sh
source cluster/config.sh

echo "Master node is ${INIT_NODE}"
redis-cli -p ${KEYDB_PORT} -h ${INIT_NODE} $@

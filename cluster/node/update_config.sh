#!/bin/bash

# This scripts will generate config file for this server.

set -ue

source config.sh
source cluster/config.sh

WDR=${DEPLOY_DIR}/keydb-${KEYDB_PORT}/
mkdir -p ${WDR}

# save former config.
if [ -e ${WDR}/keydb.conf ]; then
    mv ${WDR}/keydb.conf ${WDR}/keydb.conf.$(date +'%Y%d%m')
fi

cat >${WDR}/keydb.conf <<EOF
protected-mode no
bind 0.0.0.0
port ${KEYDB_PORT}
supervised systemd
dir ${WDR}/data/

# Disable storage provider for memory testing
# storage-provider flash ${WDR}/flash/

cluster-enabled no
replica-serve-stale-data yes

# Diskless replication is EXPERIMENTAL
repl-diskless-sync no

# memory
maxmemory 40gb
maxmemory-policy allkeys-lru

server-threads 4
EOF

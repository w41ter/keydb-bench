#!/bin/bash
set -ue

source config.sh
source cluster/config.sh

WDR=${DEPLOY_DIR}/keydb-${KEYDB_PORT}/
mkdir -p ${WDR}

if [[ ! -f ~/cluster/node/host ]]; then
    echo "host file '~/node/host' is lost"
    exit 1
fi
host=$(cat ~/cluster/node/host)

bash cluster/node/download.sh
systemctl stop keydb-${KEYDB_PORT}.service
bash cluster/node/install.sh
if [[ ${UPDATE_CONFIG:-false} == "true" ]]; then
    bash cluster/node/update_config.sh
fi
systemctl start keydb-${KEYDB_PORT}.service

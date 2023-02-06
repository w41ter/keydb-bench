#!/bin/bash

source config.sh
source cluster/config.sh

name=keydb-${KEYDB_PORT}.service
systemctl stop ${name}
systemctl disable ${name}
rm -rf /etc/systemd/system/${name}
systemctl daemon-reload

WDR=${DEPLOY_DIR}/keydb-${KEYDB_PORT}/
rm -rf ${WDR}/

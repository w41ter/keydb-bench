#!/bin/bash
set -ue

source config.sh
source cluster/config.sh

bash ~/cluster/node/download.sh
bash ~/cluster/node/install.sh
bash ~/cluster/node/update_config.sh
systemctl start keydb-${KEYDB_PORT}.service
systemctl enable keydb-${KEYDB_PORT}.service

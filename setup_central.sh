#!/bin/bash

source config.sh

echo "install softwares ..."
bash setup_node.sh
bash install/prometheus.sh
bash install/grafana.sh
bash install/nginx.sh
bash install/go.sh
bash install/memtier_benchmark.sh
bash install/redis.sh

echo "setup grafana ..."
curl --user admin:admin 'http://localhost:3000/api/datasources' \
    -X POST \
    -H 'Content-Type: application/json;charset=UTF-8' \
    --data-binary '{"name":"prometheus","isDefault":true,"type":"prometheus","url":"http://localhost:9090","access":"proxy","basicAuth":false}'

echo "begin setup private nodes ..."
bash copy_to_node.sh

for host in ${HOSTS_PRIVATE[@]}; do
    ssh ${USER}@${host} 'bash setup_node.sh' </dev/null &
done
wait

#!/bin/bash

# This script will establish ssh authorization for the central node.
source config.sh

allow_login_commands="sudo su <<EOF
sed -i 's/no-port-forwarding,no-agent-forwarding,no-X11-forwarding,command=\"echo.*exit 142\"//g' ~/.ssh/authorized_keys;
EOF"

if [ ! -z $AWS_USER ]; then
    echo "Need enable ${USER} login for AWS server"

    ssh -o StrictHostKeyChecking=no ${AWS_USER}@${HOST_CENTRAL} "${allow_login_commands}"
fi

# Install rsa keys
ssh-keygen -f ~/.ssh/known_hosts -R ${HOST_CENTRAL} >/dev/null
ssh-keyscan ${HOST_CENTRAL} >> ~/.ssh/known_hosts; >/dev/null
ssh ${USER}@${HOST_CENTRAL} 'if [ ! -f /root/.ssh/id_rsa ]; then ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa; fi'
scp ${USER}@${HOST_CENTRAL}:~/.ssh/id_rsa.pub . >/dev/null
scp ${USER}@${HOST_CENTRAL}:~/.ssh/id_rsa . >/dev/null
ssh ${USER}@${HOST_CENTRAL} "cat <<EOF >~/.ssh/config
Host *
        ServerAliveInterval 30
        StrictHostKeyChecking no
EOF"

for host in ${HOSTS[@]}; do
    if [[ $host == ${HOST_CENTRAL_PRIVATE} ]]; then
        continue
    fi

    ssh ${USER}@${HOST_CENTRAL} "\
        touch -f ~/.ssh/known_hosts; \
        chmod 0644 ~/.ssh/known_hosts; \
        ssh-keygen -f '~/.ssh/known_hosts' -R ${host}; \
        ssh-keyscan ${host} >> ~/.ssh/known_hosts; \
    " </dev/null

    # allow root login
    if [ ! -z ${AWS_USER} ]; then
        ssh -o StrictHostKeyChecking=no -J ${USER}@${HOST_CENTRAL} \
            ${AWS_USER}@${host} "${allow_login_commands}" </dev/null
    fi

	ssh-copy-id -i id_rsa.pub -o StrictHostKeyChecking=no \
        -o ProxyJump=${USER}@${HOST_CENTRAL} ${USER}@${host} </dev/null
done

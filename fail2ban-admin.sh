#!/bin/bash
if [ -z $3 ]; then echo "Usage: ./fail2ban-admin.sh <OPENVPN NAME> <addignoreip|delignoreip|banip|unbanip <IPV4>"; exit; fi

source docker.env
docker exec $1 fail2ban-client set openvpn `echo $2` `echo $3`

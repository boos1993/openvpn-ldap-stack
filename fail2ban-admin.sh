#!/bin/bash
if [ -z $2 ]; then echo "Usage: ./fail2ban-admin.sh <addignoreip|delignoreip|banip|unbanip <IPV4>"; exit; fi

source docker.env
docker exec $OPENVPN_NAME fail2ban-client set openvpn `echo $1` `echo $2`

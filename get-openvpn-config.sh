#!/bin/bash
if [ -z $1 ]; then echo "Usage: ./get-openvpn-config.sh <OPENVPN CONTAINER>"; exit; fi

source docker.env
docker exec -it $1 show-client-config > "$1.ovpn"

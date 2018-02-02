#!/bin/bash

source docker.env
docker exec -it $OPENVPN_NAME show-client-config > "@${OPENVPN_DOMAIN}.ovpn"

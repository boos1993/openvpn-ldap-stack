#!/bin/bash
source docker.env
docker exec $OPENVPN_NAME tail -50 /var/log/fail2ban.log

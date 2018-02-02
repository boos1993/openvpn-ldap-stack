#!/bin/bash
if [ -z $1 ]; then echo "Usage: ./get-docker-ip.sh <container>"; exit; fi

docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $1


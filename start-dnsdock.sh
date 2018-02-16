#!/bin/bash

source docker.env

docker stop $DNS_NAME || true
docker rm $DNS_NAME || true
docker run \
	--detach \
	--name=$DNS_NAME \
	--net=$NETWORK_NAME \
	--ip=$DNS_IPV4 \
	--restart=always \
	-v /var/run/docker.sock:/var/run/docker.sock \
	aacebedo/dnsdock:latest-amd64 \
	--domain $DNS_DOMAIN

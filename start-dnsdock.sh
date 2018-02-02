#!/bin/bash

source docker.env

docker stop $DNS_NAME > /dev/null
docker rm $DNS_NAME > /dev/null
docker run \
	-d \
	--name=$DNS_NAME \
	-v /var/run/docker.sock:/var/run/docker.sock \
	tonistiigi/dnsdock \
	--domain $DNS_DOMAIN


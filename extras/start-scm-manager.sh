#!/bin/bash

source ../docker.env

docker stop $SCM_NAME || true
docker rm $SCM_NAME || true
docker run \
	--label com.dnsdock.alias="$SCM_NAME.$DNS_DOMAIN" \
	--detach \
	--name=$SCM_NAME \
	--net=$NETWORK_NAME \
	--dns=$DNS_IPV4 \
	--ip=$SCM_IPV4 \
	--restart=always \
	-v $SCM_STORAGE_HOST:/var/lib/scm \
	sdorra/scm-manager:latest

#!/bin/bash

source ../docker.env

docker stop $SCM_NAME || true
docker rm $SCM_NAME || true
docker run \
	-d \
	--name=$SCM_NAME \
	--link $LDAP_HOSTNAME:ldap \
	-v $SCM_STORAGE_HOST:/var/lib/scm \
	sdorra/scm-manager:latest

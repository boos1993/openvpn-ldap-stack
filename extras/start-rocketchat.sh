#!/bin/bash

source ../docker.env

docker stop $ROCKETCHAT_DB_NAME || true
docker rm $ROCKETCHAT_DB_NAME || true
docker run \
	-d \
	--name=$ROCKETCHAT_DB_NAME \
	-v $ROCKETCHAT_DB_STORAGE_HOST \
	mongo:3.0 \
	$ROCKETCHAT_DB_OPTIONS

sleep 2 # Wait for the mongodb to come up

docker stop $ROCKETCHAT_NAME || true
docker rm $ROCKETCHAT_NAME || true
docker run \
	-d \
	--name=$ROCKETCHAT_NAME \
	--link $ROCKETCHAT_DB_NAME:db \
	--link $LDAP_HOSTNAME:ldap \
	rocket.chat

#!/bin/bash

source ../docker.env

docker stop $NEXTCLOUD_DB_NAME || true
docker rm $NEXTCLOUD_DB_NAME || true
docker run \
        --label com.dnsdock.alias="$NEXTCLOUD_DB_NAME.$DNS_DOMAIN" \
        --detach \
        --name=$NEXTCLOUD_DB_NAME \
        --net=$NETWORK_NAME \
        --dns=$DNS_IPV4 \
        --ip=$NEXTCLOUD_DB_IPV4 \
	-e POSTGRES_DB=$NEXTCLOUD_DB_DATABASE \
	-e POSTGRES_USER=$NEXTCLOUD_DB_USER \
	-e POSTGRES_PASSWORD=$NEXTCLOUD_DB_PASSWORD \
	-v $NEXTCLOUD_DB_STORAGE_HOST:/var/lib/postgresql/data \
	postgres

docker stop $NEXTCLOUD_NAME || true
docker rm $NEXTCLOUD_NAME || true
docker run \
        --label com.dnsdock.alias="$NEXTCLOUD_NAME.$DNS_DOMAIN" \
        --detach \
        --name=$NEXTCLOUD_NAME \
        --net=$NETWORK_NAME \
        --dns=$DNS_IPV4 \
        --ip=$NEXTCLOUD_IPV4 \
	-e POSTGRES_DB=$NEXTCLOUD_DB_DATABASE \
	-e POSTGRES_USER=$NEXTCLOUD_DB_USER \
	-e POSTGRES_PASSWORD=$NEXTCLOUD_DB_PASSWORD \
	-e POSTGRES_HOST=$NEXTCLOUD_DB_NAME \
	-v $NEXTCLOUD_STORAGE_HOST:/var/www/html \
	nextcloud

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
	--privileged=true \
	--user=root \
	sdorra/scm-manager:latest


PORT_REPLACE=$'\'s/SystemProperty name="jetty.port" default="8080"/SystemProperty name="jetty.port" default="80"/g\''

docker exec $SCM_NAME bash -c "sed -i -e $PORT_REPLACE /opt/scm-server/conf/server-config.xml"

docker restart $SCM_NAME

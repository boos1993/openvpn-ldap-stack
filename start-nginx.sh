#!/bin/bash

source docker.env

docker stop $NGINX_NAME || true
docker rm $NGINX_NAME || true
docker run \
        --label com.dnsdock.alias="$NGINX_NAME.$DNS_DOMAIN" \
	--detach \
	--name=$NGINX_NAME \
	--net=$NETWORK_NAME \
	--dns-search=$DNS_DOMAIN \
	--ip=$NGINX_IPV4 \
	-l com.dnsdock.ip_addr=$NGINX_IPV4 \
	--restart=always \
	-v $NGINX_STORAGE_HOST:/config \
	-p 80:80 \
	-p 443:443 \
	--env "PGID=1001" \
	--env "PUID=1001"  \
  	--env "EMAIL=$NGINX_LETSENCRYPT_EMAIL" \
  	--env "URL=$NGINX_LETSENCRYPT_URL" \
  	--env "SUBDOMAINS=$NGINX_LETSENCRYPT_SUBDOMAINS" \
  	--env "VALIDATION=http" \
	--env "TZ=$NGINX_LETSENCRYPT_TZ" \
	--cap-add=NET_ADMIN \
	linuxserver/letsencrypt

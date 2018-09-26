#!/bin/bash

source docker.env

docker stop $OPENVPN_STATIC_NAME || true
docker rm $OPENVPN_STATIC_NAME || true
docker run \
        --label com.dnsdock.alias="$OPENVPN_STATIC_NAME.$DNS_DOMAIN" \
	--detach \
	--name=$OPENVPN_STATIC_NAME \
	--net=$NETWORK_NAME \
	--dns-search=$DNS_DOMAIN \
	--ip=$OPENVPN_STATIC_IPV4 \
	-l com.dnsdock.ip_addr=$OPENVPN_STATIC_IPV4 \
	--restart=always \
	-v $OPENVPN_STATIC_STORAGE_HOST:/etc/openvpn \
	-p 1195:1194/udp \
	--env "OVPN_SERVER_CN=$OPENVPN_STATIC_DOMAIN" \
	--env "OVPN_PROTOCOL=$OPENVPN_STATIC_PROTOCOL" \
	--env "OVPN_NETWORK=$OPENVPN_STATIC_NETWORK" \
	--env "OVPN_ROUTES=$OPENVPN_STATIC_ROUTES" \
	--env "OVPN_NAT=$OPENVPN_STATIC_NAT" \
	--env "OVPN_DNS_SERVERS=$DNS_IPV4" \
	--env "OVPN_DNS_SEARCH_DOMAIN=$DNS_DOMAIN" \
	--env "OVPN_VERBOSITY=$OPENVPN_STATIC_VERBOSITY" \
	--env "REGENERATE_CERTS=$OPENVPN_STATIC_REGENERATE_CERTS" \
	--env "KEY_LENGTH=$OPENVPN_STATIC_KEY_LENGTH" \
	--env "DEBUG=$OPENVPN_STATIC_DEBUG" \
	--env "ENABLE_OTP=$OPENVPN_STATIC_OTP" \
	--env "OVPN_TLS_CIPHERS=$OPENVPN_STATIC_TLS_CIPHERS" \
	--env "USE_CLIENT_CERTIFICATE=true" \
	--env "FAIL2BAN_ENABLED=$OPENVPN_STATIC_FAIL2BAN_ENABLED" \
	--env "FAIL2BAN_MAXRETRIES=$OPENVPN_STATIC_FAIL2BAN_MAXRETRIES" \
	--cap-add=NET_ADMIN \
	openvpn-ldap-otp

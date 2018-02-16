#!/bin/bash

source docker.env

docker stop $OPENVPN_NAME || true
docker rm $OPENVPN_NAME || true
docker run \
        --label com.dnsdock.alias="$OPENVPN_NAME.$DNS_DOMAIN" \
	--detach \
	--name=$OPENVPN_NAME \
	--net=$NETWORK_NAME \
	--dns-search=$DNS_DOMAIN \
	--ip=$OPENVPN_IPV4 \
	-l com.dnsdock.ip_addr=$OPENVPN_IPV4 \
	--restart=always \
	-v $OPENVPN_STORAGE_HOST:/etc/openvpn \
	-p 1194:1194/udp \
	--env "OVPN_SERVER_CN=$OPENVPN_DOMAIN" \
	--env "LDAP_URI=ldap://${LDAP_NAME}" \
	--env "LDAP_BASE_DN=$LDAP_BASE_DN" \
	--env "LDAP_BIND_USER_DN=$LDAP_CONNECT" \
	--env "LDAP_BIND_USER_PASS=$LDAP_CONNECT_PASS" \
	--env "LDAP_FILTER=$OPENVPN_LDAP_FILTER" \
	--env "OVPN_PROTOCOL=$OPENVPN_PROTOCOL" \
	--env "OVPN_NETWORK=$OPENVPN_NETWORK" \
	--env "OVPN_ROUTES=$OPENVPN_ROUTES" \
	--env "OVPN_NAT=$OPENVPN_NAT" \
	--env "OVPN_DNS_SERVERS=$DNS_IPV4" \
	--env "OVPN_DNS_SEARCH_DOMAIN=$DNS_DOMAIN" \
	--env "OVPN_VERBOSITY=$OPENVPN_VERBOSITY" \
	--env "REGENERATE_CERTS=$OPENVPN_REGENERATE_CERTS" \
	--env "KEY_LENGTH=$OPENVPN_KEY_LENGTH" \
	--env "DEBUG=$OPENVPN_DEBUG" \
	--env "ENABLE_OTP=$OPENVPN_OTP" \
	--env "OVPN_TLS_CIPHERS=$OPENVPN_TLS_CIPHERS" \
	--env "USE_CLIENT_CERTIFICATE=false" \
	--cap-add=NET_ADMIN \
	openvpn-ldap-otp


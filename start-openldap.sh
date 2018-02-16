#!/bin/bash -e
source docker.env

docker stop $LDAP_NAME || true
docker rm $LDAP_NAME || true
docker run \
	--label com.dnsdock.alias="$LDAP_NAME.$DNS_DOMAIN" \
	--detach \
	--name $LDAP_NAME \
	--hostname "$LDAP_NAME" \
	--net=$NETWORK_NAME \
	--ip=$LDAP_IPV4 \
	--dns=$DNS_IPV4	\
	--restart=always \
	--env LDAP_DOMAIN=$LDAP_DOMAIN \
	--env LDAP_ADMIN_PASSWORD=$LDAP_CONNECT_PASS \
	-v $LDAP_DATABASE:/var/lib/ldap \
	-v $LDAP_CONFIG:/etc/ldap/slapd.d \
	osixia/openldap:1.1.8

docker stop $PHPLDAP_NAME || true
docker rm $PHPLDAP_NAME || true
docker run \
	--label com.dnsdock.alias="$PHPLDAP_NAME.$DNS_DOMAIN" \
	--detach \
	--name $PHPLDAP_NAME \
	--hostname "$PHPLDAP_NAME" \
	--net=$NETWORK_NAME \
	--dns=$DNS_IPV4	\
	--ip=$PHPLDAP_IPV4 \
	--restart=always \
	--env PHPLDAPADMIN_HTTPS=false \
	--env PHPLDAPADMIN_LDAP_HOSTS="#PYTHON2BASH:[{'${LDAP_NAME}': [{'server': [{'tls': False}]},{'login': [{'bind_id': '${LDAP_CONNECT}'}]}]}]" \
	osixia/phpldapadmin:0.7.1

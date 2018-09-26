#!/bin/bash

source ../docker.env

docker stop $GUACD_NAME || true
docker rm $GUACD_NAME || true
docker run \
        --label com.dnsdock.alias="$GUACD_NAME.$DNS_DOMAIN" \
        --detach \
        --name=$GUACD_NAME \
        --net=$NETWORK_NAME \
        --dns=$DNS_IPV4 \
        --ip=$GUACD_IPV4 \
	-d \
        --restart=always \
	guacamole/guacd
docker stop $GUACAMOLE_NAME || true
docker rm $GUACAMOLE_NAME || true
docker run \
        --label com.dnsdock.alias="$GUACAMOLE_NAME.$DNS_DOMAIN" \
        --detach \
        --name=$GUACAMOLE_NAME \
        --net=$NETWORK_NAME \
        --dns=$DNS_IPV4 \
        --ip=$GUACAMOLE_IPV4 \
	--env "GUACD_HOSTNAME=$GUACD_IPV4" \
	--env "GUACD_PORT=4822" \
	--env "LDAP_HOSTNAME=${LDAP_NAME}.${DNS_DOMAIN}" \
	--env "LDAP_USER_BASE_DN=dc=avilution,dc=com" \
	--env "LDAP_SEARCH_BIND_DN=cn=admin,dc=avilution,dc=com" \
	--env "LDAP_SEARCH_BIND_PASSWORD=$LDAP_CONNECT_PASS" \
	--env "LDAP_CONFIG_BASE_DN=dc=avilution,dc=com" \
        --restart=always \
	guacamole/guacamole
	#--env "LDAP_USERNAME_ATTRIBUTE=cn" \
	

#--env "LDAP_ENCRYPTION_METHOD=none" \
#--env "LDAP_PORT=389" \
#--env "LDAP_GROUP_BASE_DN=ou=Groups,dc=avilution,dc=com" \

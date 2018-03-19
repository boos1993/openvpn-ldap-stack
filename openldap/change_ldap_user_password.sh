#!/bin/bash
source ../docker.env
if [ -z $1 ]; then echo "Usage: ./change_ldap_user_password.sh <user>"; exit; fi

echo "Enter Password"
read -s PASSWORD
docker exec -it ${LDAP_NAME} ldappasswd -s $PASSWORD -D $LDAP_CONNECT -x "uid=${1},ou=Users,${LDAP_BASE_DN}" -w $LDAP_CONNECT_PASS


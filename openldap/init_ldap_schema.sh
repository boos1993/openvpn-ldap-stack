#!/bin/bash

source ../docker.env
docker exec -i ${LDAP_NAME} ldapadd -xvD $LDAP_CONNECT -w $LDAP_CONNECT_PASS <<EOF
dn: ou=Users,${LDAP_BASE_DN}
ou: Users
objectClass: top
objectclass: organizationalunit
EOF


docker exec -i ${LDAP_NAME} ldapadd -xvD $LDAP_CONNECT -w $LDAP_CONNECT_PASS <<EOF
dn: ou=Groups,${LDAP_BASE_DN}
ou: Groups
objectClass: top
objectclass: organizationalunit
EOF


docker exec -i ${LDAP_NAME} ldapadd -xvD $LDAP_CONNECT -w $LDAP_CONNECT_PASS <<EOF
dn: cn=users,ou=Groups,${LDAP_BASE_DN}
cn: users
gidNumber: 1000
objectClass: posixGroup
EOF


#!/bin/bash
source ../docker.env
if [ "$#" -ne 3 ]; then echo "Usage: ./add_ldap_user.sh <user> <uidNumber> <gidNumber>"; exit; fi

USER_UID=$1
USER_UIDNUM=$2
USER_GIDNUM=$3

docker exec -i ${LDAP_NAME} ldapadd -xvD $LDAP_CONNECT -w $LDAP_CONNECT_PASS <<EOF
dn: uid=${USER_UID},ou=Users,${LDAP_BASE_DN}
objectClass: top
objectClass: account
objectClass: posixAccount
objectClass: shadowAccount
cn: ${USER_UID}
uid: ${USER_UID}
uidNumber: ${USER_UIDNUM}
gidNumber: ${USER_GIDNUM}
homeDirectory: /home/${USER_UID}
loginShell: /bin/bash
gecos: ${USER_UID}
userPassword: {SSHA}x
shadowLastChange: 0
shadowMax: 0
shadowWarning: 0
EOF

./change_ldap_user_password.sh $USER_UID


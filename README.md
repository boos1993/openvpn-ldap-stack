# LDAP OpenVPN Stack
This is a compilation of scripts that makes it easy to deploy a openldap server with phpldapadmin and have it be the authentication backend for an OpenVPN server.

## Prerequisites
In order to run the OpenVPN server, you will first need to build the image at [boos1993/openvpn-server-ldap-otp](https://github.com/boos1993/openvpn-server-ldap-otp).

```
git clone https://github.com/boos1993/openvpn-server-ldap-otp
docker build -t openvpn-ldap-otp ./openvpn-server-ldap-otp
```
## Starting the OpenVPN LDAP stack
1) First clone this repository.
```
git clone https://github.com/boos1993/openvpn-ldap-stack && cd openvpn-ldap-stack/ 
```
2) Setup your environment variables
```
cp example.env docker.env
```
Then edit `docker.env` to match your desired configuration.

3) Start DNSDock
```
./start-dnsdock.sh
```

4) Start OpenLDAP and PHPLDAPAdmin
```
./start-openldap.sh
```

5) Configure your LDAP server
```
cd openldap
./init_ldap_schema.sh
./add_ldap_user <username> <user UID> <group GID>
cd ..
```

6) Start OpenVPN
```
./start-openvpn.sh
```

7) Create your OpenVPN config file (@yourdomain.com.ovpn)
```
./get-openvpn-config.sh
```

## Extras
I've included some extra docker run scripts that are setup to use the environment variables from this repo. They are optional but I find them to be very useful.

### NextCloud
I highly recommend NextCloud for online file storage, chat, calendar, etc. It is easy to use with a nice web interface and also supports LDAP authentication. The container creation is scripted but still requires manually configuring NextCloud to use the LDAP authentication module.
```
cd extras
./start-nextcloud.sh
```
<TODO: Add instructions for enabling NextCloud LDAP authentication>

### SCM Manager
SCM manager is a great tool for hosting your own code repositories. It allows you to authenticate via LDAP and set different permissions for those LDAP users. It requires some manual setup to enable LDAP authentication but the container creation is scripted.

```
cd extras
./start-scm-manager.sh
```
<TODO: Add instructions for enabling SCM Manager LDAP authentication>

## Connecting to your OpenVPN network
Just download your @yourdomain.com.ovpn file to the client you intend to connect your VPN and login with the LDAP user credentials the were created in step 4. 

## Opening PHPLDAPAdmin
After connecting to the VPN, navigate to <LDAP_HOSTNAME>.<OPENVPN_DNS_SEARCH_DOMAIN>. Based on example.env this would be phpldapadmin.example.net. You can then login using <LDAP_CONNECT> and <LDAP_CONNECT_PASS>.

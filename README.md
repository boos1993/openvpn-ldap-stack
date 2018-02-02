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

3) Start OpenLDAP and PHPLDAPAdmin
```
./start-openldap.sh
```

4) Configure your LDAP server
```
cd openldap
./init_ldap_schema.sh
./add_ldap_user <username> <user UID> <group GID>
cd ..
```

5) Start OpenVPN
```
./start-openvpn.sh
```

6) Create your OpenVPN config file (@yourdomain.com.ovpn)
```
./get-openvpn-config.sh
```

## Connecting to your OpenVPN network
Just download your @yourdomain.com.ovpn file to the client you intend to connect your VPN and login with the LDAP user credentials the were created in step 4. 

## Opening PHPLDAPAdmin
After connecting to the VPN, navigate to <LDAP_HOSTNAME>.<OPENVPN_DNS_SEARCH_DOMAIN>. Based on example.env this would be phpldapadmin.example.net. You can then login using <LDAP_CONNECT> and <LDAP_CONNECT_PASS>.

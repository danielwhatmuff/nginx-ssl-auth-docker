# NGINX SSL reverse proxy to another Docker container, with basic auth

## Overview

- Provides SSL termination using NGINX running inside a Docker container
- Provides basic auth, using htpassword file
- Forward requests securely to a linked container, or to another backend

## Usage
- Create certificate, key and Diffie-Hellman cert
```bash
$ openssl dhparam -out dh.pem 2048
$ openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout cert.key -out cert.crt
```
- Create .htpasswd file
```
$ htpasswd -c .htpasswd username
```
- Configure FQDN in site.conf
- Configure proxy_pass and proxy_redirect in site.conf to be the name of a linked container or another backend
- Build image, run service container and then run the proxy container and link it to your service
```
$ docker build -t nginx-myservice .
$ docker run -d --name backend -p 8080:8080 dockerimage
$ docker run -d --link backend -p 80:80 -p 443:443 nginx-myservice
```
- Note: The '--link mydockerservice' will create a hosts entry in the proxy container, which must match the one in site.conf

# NGINX SSL reverse proxy to another Docker container, with basic auth

## Overview

- Provides SSL termination using NGINX running inside a Docker container
- Provides basic auth, using htpassword file
- Forward requests securely to a linked container, or to another backend
- Logs nginx access_log messages to stdout

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
- Build image
```
$ docker build -t nginx-ssl-auth .
```
- Run the container you wish to proxy to
```
$ docker run -d --name myservice <dockerimage>
```
- Run the nginx-ssl-auth container, pass environment variables and mount certs/htpasswd/dhparam
```
$ docker run -d --link myservice \
             -e 'LINKED_CONTAINER_NAME=myservice' \ 
             -e 'LINKED_CONTAINER_PORT=8080' \
             -p 80:80 \
             -p 443:443 \
             -v $(pwd)/cert.crt:/etc/nginx/cert.crt \
             -v $(pwd)/cert.key:/etc/nginx/cert.key \
             -v $(pwd)/dh.pem:/etc/nginx/dh.pem \
             -v $(pwd)/.htpasswd: 
             nginx-ssl-auth
```
- Note: The '--link myservice' must match the container name and the port must match too

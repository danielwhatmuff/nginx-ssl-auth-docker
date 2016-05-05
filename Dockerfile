FROM nginx:1.7

MAINTAINER "Daniel Whatmuff" <danielwhatmuff@gmail.com>

LABEL name="AMP NGINX with SSL"

# Remove any existing config
RUN rm -rf /etc/nginx/conf.d/*

# Copy in configuration files
COPY nginx.conf /etc/nginx/nginx.conf
COPY basic.conf /etc/nginx/conf.d/basic.conf
COPY ssl.conf /etc/nginx/ssl.conf
COPY site.conf /etc/nginx/sites-enabled/site.conf

# COPY in certs and auth
COPY dh.pem /etc/nginx/dh.pem
COPY cert.crt /etc/nginx/cert.crt
COPY cert.key /etc/nginx/cert.key
COPY .htpasswd /etc/nginx/.htpasswd

CMD ["nginx"]

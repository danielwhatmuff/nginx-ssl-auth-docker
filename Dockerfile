FROM nginx:1.7

MAINTAINER "Daniel Whatmuff" <danielwhatmuff@gmail.com>

LABEL name="AMP NGINX with SSL and Auth"

# Remove any existing config
RUN rm -rf /etc/nginx/conf.d/*

# Create link to log access to stdout
RUN ln -sf /proc/self/fd /dev/

# Copy in configuration files
COPY nginx.conf /etc/nginx/nginx.conf
COPY basic.conf /etc/nginx/conf.d/basic.conf
COPY ssl.conf /etc/nginx/ssl.conf
COPY site.conf /etc/nginx/sites-enabled/site.conf
COPY entry_point.sh /bin/entry_point.sh

RUN chmod +x /bin/entry_point.sh

CMD ["/bin/entry_point.sh"]

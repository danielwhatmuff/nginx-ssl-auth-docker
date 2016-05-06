#!/bin/bash
# Entry script to configure linked name and port
set -e

# Set the default
DEFAULT_NAME="backend"
DEFAULT_PORT="8000"

# Use default if none specified as env var
LINKED_CONTAINER_NAME=${LINKED_CONTAINER_NAME:-$DEFAULT_NAME}
LINKED_CONTAINER_PORT=${LINKED_CONTAINER_PORT:-$DEFAULT_PORT}

# Print message

echo -e "Using linked container name $LINKED_CONTAINER_NAME"
echo -e "Using linked container port $LINKED_CONTAINER_PORT"

# Swap out the config

sed -i "s/backend/${LINKED_CONTAINER_NAME}/g" /etc/nginx/sites-enabled/site.conf
sed -i "s/8000/${LINKED_CONTAINER_PORT}/g" /etc/nginx/sites-enabled/site.conf

# Start nginx

echo "Starting nginx"

nginx

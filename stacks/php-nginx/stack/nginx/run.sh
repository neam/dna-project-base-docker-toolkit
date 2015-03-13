#!/bin/bash

# This script is run within the nginx:1.7-based container on start

# Fail on any error
set -o errexit

# Setup config variables only available at runtime
if [ ! -n "$PHP_PORT_9000_TCP_ADDR" ] ; then
    echo "Warning: The env var PHP_PORT_9000_TCP_ADDR is missing - the generated configuration will not work"
fi
if [ ! -n "$PHP_PORT_9000_TCP_PORT" ] ; then
    echo "Warning: The env var PHP_PORT_9000_TCP_PORT is missing - the generated configuration will not work"
fi
sed -i "s|\${PHP_PORT_9000_TCP_ADDR}|${PHP_PORT_9000_TCP_ADDR}|" /etc/nginx/conf.d/php-fpm.conf
sed -i "s|\${PHP_PORT_9000_TCP_PORT}|${PHP_PORT_9000_TCP_PORT}|" /etc/nginx/conf.d/php-fpm.conf

# Example of using environment variable in configuration at runtime
if [ ! -n "$NGINX_ERROR_LOG_LEVEL" ] ; then
    NGINX_ERROR_LOG_LEVEL="warn"
fi
sed -i "s|\${NGINX_ERROR_LOG_LEVEL}|${NGINX_ERROR_LOG_LEVEL}|" /etc/nginx/nginx.conf

# Run nginx
nginx -g 'daemon off;'

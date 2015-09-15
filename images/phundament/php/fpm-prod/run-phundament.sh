#!/bin/bash

# This script is run within the php containers on start

# Fail on any error
set -o errexit

# Setup config variables only available at runtime
sed -i "s|\${DISPLAY_PHP_ERRORS}|${DISPLAY_PHP_ERRORS}|" /usr/local/etc/php/conf.d/app.ini

# Work around permission errors locally TODO only if local
usermod -u 1000 www-data

# Run the command sent as command line arguments
php-fpm

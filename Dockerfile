FROM richan/php:8.3-fpm-nginx

COPY . /var/www/html

ENV WEBROOT /var/www/html/public
ENV PHP_ERRORS_STDERR 1
ENV RUN_SCRIPTS 1
ENV REAL_IP_HEADER 1
ENV COMPOSER_ALLOW_SUPERUSER 1

USER root

# Install Node.js for Vite build
RUN apt-get update && apt-get install -y nodejs npm && rm -rf /var/lib/apt/lists/*

# Debug: confirm actual PHP CLI version
RUN php -v && which php

# Composer install
RUN composer install --no-dev --optimize-autoloader --ignore-platform-reqs
RUN npm install
RUN npm run build

EXPOSE 80
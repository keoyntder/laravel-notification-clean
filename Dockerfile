FROM serversideup/php:8.4-fpm-nginx

USER root

COPY . /var/www/html

ENV NGINX_WEBROOT=/var/www/html/public
ENV PHP_ERRORS_STDERR=1
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV APP_ENV=production
ENV APP_DEBUG=false

# Install Node.js and npm
RUN apt-get update \
    && apt-get install -y nodejs npm \
    && rm -rf /var/lib/apt/lists/*

# Install PostgreSQL PHP extension for Supabase
RUN install-php-extensions pdo_pgsql

# Install Laravel dependencies
RUN composer install \
    --no-dev \
    --optimize-autoloader \
    --no-interaction

# Install frontend dependencies and build Vite
RUN npm install
RUN npm run build

EXPOSE 8080
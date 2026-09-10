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

# Install PostgreSQL extension for Supabase
RUN install-php-extensions pdo_pgsql

# Fix Laravel storage and cache permissions
RUN mkdir -p /var/www/html/storage/logs \
    /var/www/html/storage/framework/cache \
    /var/www/html/storage/framework/sessions \
    /var/www/html/storage/framework/views \
    /var/www/html/bootstrap/cache \
    && chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Install Composer dependencies
RUN composer install \
    --no-dev \
    --optimize-autoloader \
    --no-interaction

# Install frontend dependencies and build Vite
RUN npm install
RUN npm run build

EXPOSE 8080
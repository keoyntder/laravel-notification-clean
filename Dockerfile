FROM richarvey/nginx-php-fpm:latest

COPY . /var/www/html

ENV WEBROOT /var/www/html/public
ENV PHP_ERRORS_STDERR 1
ENV RUN_SCRIPTS 1
ENV REAL_IP_HEADER 1
ENV COMPOSER_ALLOW_SUPERUSER 1

# Install Node.js for Vite build
RUN apk add --no-cache nodejs npm

# Force composer to respect PHP 8.2 compatibility
RUN composer install --no-dev --optimize-autoloader --ignore-platform-reqs
RUN npm install
RUN npm run build

EXPOSE 80
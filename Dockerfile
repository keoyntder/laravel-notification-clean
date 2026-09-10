FROM richarvey/nginx-php-fpm:latest

COPY . /var/www/html

ENV WEBROOT /var/www/html/public
ENV PHP_ERRORS_STDERR 1
ENV RUN_SCRIPTS 1
ENV REAL_IP_HEADER 1
ENV COMPOSER_ALLOW_SUPERUSER 1

USER root

# Install Node.js and npm for Vite
RUN apk add --no-cache nodejs npm

# Install Composer dependencies
RUN composer install --no-dev --optimize-autoloader --no-interaction

# Install frontend dependencies and build Vite assets
RUN npm install
RUN npm run build

EXPOSE 80

CMD ["/start.sh"]
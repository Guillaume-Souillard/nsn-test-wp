FROM php:8.3-fpm

RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    git \
    mariadb-client \
    && docker-php-ext-install mysqli pdo_mysql

# install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html

COPY bedrock /var/www/html

RUN composer install --no-interaction --prefer-dist --no-dev --optimize-autoloader

RUN chown -R www-data:www-data /var/www/html

EXPOSE 9000

CMD ["php-fpm"]

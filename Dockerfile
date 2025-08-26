FROM php:8.1-fpm

# 必要な拡張を入れる
RUN apt-get update && apt-get install -y \
    unzip git curl mariadb-client libzip-dev libpng-dev libonig-dev libxml2-dev \
    && docker-php-ext-install pdo pdo_mysql mbstring zip exif pcntl gd bcmath

# Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# ソースコード配置
WORKDIR /var/www/html
COPY . .

RUN composer install --no-dev --optimize-autoloader
RUN php artisan key:generate

FROM php:8.0.3-fpm-alpine3.13
LABEL maintainer="thegk-rh"

ARG PHP_UPSTREAM_PORT=9001
RUN sed -i 's/9000/9001/' /usr/local/etc/php-fpm.d/zz-docker.conf

COPY php.ini /usr/local/etc/php/
COPY --from=composer:2.0 /usr/bin/composer /usr/bin/composer

# If you want to use xdebug, add autoconf, gcc, g++ and make in line:14.
RUN set -eux \
  && apk --no-cache add tzdata postgresql-dev libzip-dev \
  && docker-php-ext-install pdo_mysql pdo_pgsql zip opcache \
  && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
  && apk del tzdata \
  && rm -rf /var/cache/apk/*

WORKDIR /var/www

EXPOSE 9001
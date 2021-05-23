FROM php:8.0.3-fpm-alpine3.13
LABEL maintainer="thegk-rh"

ARG PHP_UPSTREAM_PORT=9001
RUN sed -i 's/9000/9001/' /usr/local/etc/php-fpm.d/zz-docker.conf

COPY php.ini /usr/local/etc/php/

# If you want to use xdebug, add autoconf, gcc, g++ and make in line:14.
# tzdata: Time zone setting
# postgresql-dev: A sophisticated object-relational DBMS (development files)
# libzip-dev: Library for reading, creating, and modifying zip archives (development)
RUN set -eux \
  && apk --no-cache add tzdata postgresql-dev libzip-dev \
  && docker-php-ext-install pdo_mysql zip opcache \
  && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
  && apk del tzdata \
  && rm -rf /var/cache/apk/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www

EXPOSE 9001
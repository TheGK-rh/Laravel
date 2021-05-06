FROM node:16-alpine as node
FROM nginx:1.20-alpine

COPY nginx.conf /etc/nginx/

# TODO:修正
RUN apk update && \
  apk add --update --no-cache --virtual=.build-dependencies g++

RUN apk --no-cache add tzdata \
  && cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
  && apk del tzdata

RUN set -x ; \
    addgroup -g 82 -S www-data ; \
    adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1

ARG PHP_UPSTREAM_CONTAINER=app
ARG PHP_UPSTREAM_PORT=9001

RUN echo "upstream php-upstream { server ${PHP_UPSTREAM_CONTAINER}:${PHP_UPSTREAM_PORT}; }" > /etc/nginx/conf.d/upstream.conf \
  && rm /etc/nginx/conf.d/default.conf

# node command
COPY --from=node /usr/local/bin /usr/local/bin
# npm command
COPY --from=node /usr/local/lib /usr/local/lib
# yarn command
COPY --from=node /opt /opt

WORKDIR /var/www

CMD ["nginx"]
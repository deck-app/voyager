FROM php:7.3.3-fpm-alpine3.8
LABEL maintainer Naba Das <hello@get-deck.com>

ENV COMPOSER_ALLOW_SUPERUSER=1
RUN apk update
RUN apk add --no-cache nginx supervisor git
RUN apk add --no-cache composer nodejs nodejs-npm
RUN docker-php-ext-install pdo_mysql
RUN mkdir /run/nginx
ADD config/php/base.ini /etc/php7/conf.d/base.ini
ADD config/nginx/default.conf /etc/nginx/conf.d/default.conf
COPY config/supervisor/supervisor.d/nginx.ini /etc/supervisor.d/nginx.ini
COPY config/supervisor/supervisor.d/php-fpm.ini /etc/supervisor.d/php-fpm.ini
COPY config/supervisor/supervisord.conf /etc/supervisord.conf
VOLUME /app
WORKDIR /app
# COPY -a src/* /app/
# RUN composer install --no-dev -o
EXPOSE 80

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT [ "sh", "/usr/local/bin/docker-entrypoint.sh" ]

CMD ["/usr/bin/supervisord", "--nodaemon", "-c", "/etc/supervisord.conf"]
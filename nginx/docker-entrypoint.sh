#!/bin/bash
set -e

HOST=`hostname`
NAME=`echo $HOST | sed 's:.*-::'`
sudo sed -i "s/{DB_HOSTNAME}/$NAME/g" /app/app.env

if [[ -f "/var/www/composer.json" ]] ;
then
    cd /var/www/
    if [[ -d "/var/www/vendor" ]] ;
    then
        echo "Composer optimize autoloader"
        composer update --prefer-dist --no-interaction --optimize-autoloader --no-dev
        echo "Laravel - Clear All [Development]"
        php artisan view:clear
        php artisan route:clear
        php artisan config:clear
        php artisan clear-compiled
    else
        echo "Composer vendor folder was not installed. Running $> composer install --prefer-dist --no-interaction --optimize-autoloader --no-dev"
        composer install --prefer-dist --no-interaction --optimize-autoloader --no-dev
    fi

fi
if [[ "$(ls -A "/var/www/")" ]] ;
    then
        echo "Directory is not Empty, Please deleted hiden file and directory"
    else
        composer create-project --prefer-dist laravel/laravel:^{LARAVEL_VERSION}.0 .
        composer require tcg/voyager
        sudo cp /app/app.env /var/www/.env
        php artisan voyager:install
        php artisan config:clear
        php artisan migrate
        php artisan voyager:install --with-dummy --force
fi
echo "Application environment variable check"
if [[ ! -f ".env" ]] ;
then
    echo ".env file not found"
    cp /app/app.env /var/www/.env
else
    echo ".env file exit"
fi

cp /app/default.conf /etc/nginx/conf.d/default.conf
sudo rm -rf /var/preview
pkill -9 php
nginx -s reload

exec "$@"
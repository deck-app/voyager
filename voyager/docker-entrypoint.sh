#!/bin/sh
cd /app
FILE=/var/www/public/web.config
if [ -f "$FILE" ]; then
    echo "$FILE exists."
else
    echo "$FILE not exists."
    git clone https://github.com/nabad600/voyager.git .
fi
composer install
chmod -R 777 storage/
php artisan key:generate
php artisan config:clear
php artisan migrate
php artisan voyager:install --with-dummy --force

exec "$@"
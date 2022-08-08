#!/bin/bash
#!/bin/bash
set -e

HOST=`hostname`
NAME=`echo $HOST | sed 's:.*-::'`
sed -i "s/{DB_HOSTNAME}/$NAME/g" /app/env.php

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
        php artisan voyager:install --with-dummy --force
        php artisan config:clear
fi
echo "Application environment variable check"
if [[ ! -f ".env" ]] ;
then
    echo ".env file not found"
    sudo cp /app/app.env /var/www/.env
else
    echo ".env file exit"
fi
cp /app/httpd.conf /etc/apache2/httpd.conf
sudo rm -rf /var/preview
httpd -k graceful

exec "$@"
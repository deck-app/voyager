#!/bin/bash
#!/bin/bash
set -e

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
        cp /app/app.env /var/www/.env
        composer require tcg/voyager
        php artisan voyager:install --with-dummy --force
        php artisan config:clear
fi
echo "Application environment variable check"
if [[ ! -f ".env" ]] ;
then
    echo ".env file not found"
    cp /app/app.env /var/www/.env
else
    echo ".env file exit"
fi
cp /app/httpd.conf /etc/apache2/httpd.conf
rm -rf /var/preview
if [ "$(stat -c '%a' /var/www/storage)" == "apache:apache" ]
then
  echo "Storage folder already write permissions"
else
  chown -R apache:apache /var/www/storage
fi
kill -TERM `cat /var/run/apache2/httpd.pid`
httpd -k graceful

exec "$@"
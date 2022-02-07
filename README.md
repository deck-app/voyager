# laravel
## Introduction
Laravel is a web application framework for PHP, released as free and open-source software under the MIT License.

Deck Laravel Development Container has been carefully engineered to provide you and your team with a highly reproducible Laravel development environment. We hope you find the Deck Laravel Development Container useful in your quest for world domination. Happy hacking!

### Install
#### Using DECK
Install voyager from the DECK marketplace and follow the instructions on the GUI
#### From terminal with Docker

Clone the application directory:
```
$ git clone https://github.com/deck-app/voyager.git
$ cd voyager
```
Edit `.env` file to change any settings before installing like php, apache, laravel versions etc

Finally launch the Laravel application development environment using:
```
$ docker-compose up -d
```
#### Modifying project settings
From the DECK app, go to stack list and click on project's `More > configure > Advanced configuration` Follow the instructions below and restart your stack from the GUI

#### Edit Apache or Nginx configuration
##### Apache
httpd.conf is located at `./apache/httpd.conf`
##### Nginx
default.conf is located at `./nginx/default.conf`
#### Editing php.in
PHP ini file is located at `./apache/php_ini/php.ini`

#### Installing / removing PHP extensions
Add / remove PHP extensions from `./apache/Dockerfile-{YOUR.PHP.VERSION}`
````
RUN apk add --update --no-cache bash \
				curl \
				curl-dev \
				php8-intl \
				php8-openssl \
				php8-dba \
				php8-sqlite3
```

#### Rebuilding from terminal
You have to rebuild the docker image after you make any changes to the project configuration, use the snippet below to rebuild and restart the stack
`docker-compose stop && docker-compose up --build -d`
# Voyager
## Introduction
Laravel Admin & BREAD System (Browse, Read, Edit, Add, & Delete), supporting Laravel 6 and newer!

### Install
#### Using DECK
Install voyager from the DECK marketplace and follow the instructions on the GUI
#### From terminal with Docker

Clone the application directory:
```
$ git clone https://github.com/deck-app/voyager.git
$ cd voyager
```
Edit `.env` file to change any settings before installing like php, apache, Voyager versions etc

Finally launch the Voyager application development environment using:
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
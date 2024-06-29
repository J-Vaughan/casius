FROM php:7.4-apache as base

RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable pdo_mysql 
RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y libzip-dev
RUN docker-php-ext-install zip && docker-php-ext-enable zip

EXPOSE 80:80

COPY ./providence /var/www/html

RUN chmod -R 777 /var/www/html/vendor/ezyang/htmlpurifier/library/HTMLPurifier/DefinitionCache/Serializer
RUN mkdir -p /var/www/html/app/tmp && chmod -R 777 /var/www/html/app/tmp
RUN chmod -R 777 /var/www/html/app/log
RUN chmod -R 777 /var/www/html/media

COPY ./setup.php /var/www/html
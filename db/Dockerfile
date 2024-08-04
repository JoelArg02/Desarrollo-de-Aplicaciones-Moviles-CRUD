FROM php:7.4-apache

# Instalar extensiones necesarias
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

# Copiar el contenido de la carpeta local www a la carpeta del servidor web
COPY ./www /var/www/html

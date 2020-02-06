FROM php:7.4-cli

MAINTAINER Camille Hernoux <caher@smile.fr>


ENV PHP_MEMORY_LIMIT 2G
ENV PHP_ENABLE_XDEBUG false
ENV MAGENTO_ROOT /var/www/html

ENV DEBUG false
ENV UPDATE_UID_GID false

ENV MAGENTO_RUN_MODE developer
ENV UPLOAD_MAX_FILESIZE 64M

ENV COMPOSER_MAGENTO_USERNAME ""
ENV COMPOSER_MAGENTO_PASSWORD ""

RUN apt-get update \
  && apt-get install -y \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libxslt1-dev \
    sendmail-bin \
    sendmail \
    sudo \
    libzip-dev \
    libonig-dev

RUN docker-php-ext-install \
  dom \
  gd \
  intl \
  mbstring \
  pdo_mysql \
  xsl \
  zip \
  soap \
  bcmath \
  pcntl

RUN pecl install -o -f xdebug

COPY usr/local/etc/php/conf.d/php-xdebug.ini /usr/local/etc/php/conf.d/php-xdebug.ini
COPY usr/local/etc/php/conf.d/mail.ini /usr/local/etc/php/conf.d/mail.ini

# Get composer installed to /usr/local/bin/composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY entrypoint.sh /entrypoint.sh

RUN ["chmod", "+x", "/entrypoint.sh"]

ENTRYPOINT ["/entrypoint.sh"]



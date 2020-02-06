#!/bin/bash

[ "$DEBUG" = "true" ] && set -x


# Substitute in php.ini values
[ ! -z "${PHP_MEMORY_LIMIT}" ] && sed -i "s/!PHP_MEMORY_LIMIT!/${PHP_MEMORY_LIMIT}/" /usr/local/etc/php/conf.d/zz-magento.ini
[ ! -z "${UPLOAD_MAX_FILESIZE}" ] && sed -i "s/!UPLOAD_MAX_FILESIZE!/${UPLOAD_MAX_FILESIZE}/" /usr/local/etc/php/conf.d/zz-magento.ini

# Configure composer
mkdir /var/www/.composer
chown -Rf www-data:www-data /var/www/.composer

[ ! -z "${COMPOSER_MAGENTO_USERNAME}" ] && \
    su www-data -s /bin/bash -c "composer config --global http-basic.repo.magento.com $COMPOSER_MAGENTO_USERNAME $COMPOSER_MAGENTO_PASSWORD"

su www-data -s /bin/bash -c "$*"

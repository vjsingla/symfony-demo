#!/usr/bin/env bash

set -e

sed -i "s/www-data/root/g" /usr/local/etc/php-fpm.d/www.conf && \
    php -d memory_limit=-1 /bin/composer install \
        --no-ansi \
        --no-dev \
        --prefer-dist \
        --no-interaction \
        --no-progress \
        --no-scripts \
        --optimize-autoloader \
        --working-dir \
            $SRC_PATH
#!/usr/bin/env bash

set -e

cd /var/www/application/

echo '> Enabling xDebug...'
cp -f docker/ApiApplication/config/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

echo '> Install dependencies'
php -d memory_limit=-1 /bin/composer install \
            --working-dir \
                /var/www/application

#echo '> Set up PHP Code Sniffer...'
#./vendor/bin/phpcs --config-set installed_paths ../../../vendor/squizlabs/php_codesniffer/,../../../vendor/m6web/symfony2-coding-standard/


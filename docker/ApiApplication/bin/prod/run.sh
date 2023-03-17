#!/usr/bin/env bash

set -e

cd $SRC_PATH

echo '> Run migration...'
php artisan migrate --database=default

echo $START_MESSAGE
touch $LOCK_FILE_PATH

php-fpm -RF --nodaemonize

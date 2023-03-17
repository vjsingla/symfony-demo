#!/usr/bin/env bash

set -e

cd $SRC_PATH

$APP_BIN_PATH/dev/pre_run.sh

#echo '> Refresh database schema...'
## refresh data
#php artisan migrate:refresh

#echo '> Seed dev database ...'
## seed data
#php artisan db:seed

echo $START_MESSAGE
touch $LOCK_FILE_PATH

/usr/sbin/sshd -D & php-fpm -RF --nodaemonize

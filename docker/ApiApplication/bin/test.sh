#!/usr/bin/env bash

set -e

cd /var/www/application/

$APP_BIN_PATH/dev/pre_run.sh

echo '> Run migration...'
php artisan migrate --database=default

echo '> Running PHP Code Sniffer...'
PHPCS_FILES=`find . -name "*.php" -not -path "./vendor/*" -not -path "./var/*" -not -path "./lint/*" -not -path "./bin/*" -not -path "./build/*"  -not -path "./database/*" -not -path "./tests/*"  -not -path "./images/*" | tr '\n' ' '`
./vendor/bin/phpcs --standard=./lint/phpcs/ruleset.xml $PHPCS_FILES

echo '> Running PHP Mess Detector...'
PHPMD_FILES=`find . -name "*.php" -not -path "./vendor/*" -not -path "./var/*" -not -path "./lint/*" -not -path "./bin/*" -not -path "./build/*"  -not -path "./database/*" -not -path "./tests/*"  -not -path "./images/*" | tr '\n' ',' | sed 's/,$//'`
./vendor/bin/phpmd $PHPMD_FILES text ./lint/phpmd/ruleset.xml

echo '> Seed test database...'
php artisan migrate:refresh

echo '> Running Tests...'
./vendor/phpunit/phpunit/phpunit --verbose -c phpunit.xml.dist

echo '> Checking code coverage...'
php /usr/local/bin/coverage-checker ./build/coverage/coverage.xml 74

echo '> Checking swagger.json...'
php artisan swagger:generate /tmp/swagger.json localhost
swagger-cli validate /tmp/swagger.json
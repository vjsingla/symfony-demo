FROM php:8.1-fpm

RUN apt-get update -qq --fix-missing && \
#INSTALL TOOLS
    apt-get install -y --no-install-recommends \
        wget

#COMPOSER
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/bin --filename=composer

#RUN bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"

RUN curl -LO https://github.com/DataDog/dd-trace-php/releases/latest/download/datadog-setup.php && \
    php datadog-setup.php --php-bin=all && \
    sed -i 's@extension \?= \?ddappsec.so@;extension = ddappsec.so@g' $PHP_INI_DIR/conf.d/*.ini

ARG RUN_MODE
ENV RUN_MODE ${RUN_MODE:-prod}
ENV APP_BIN_PATH /usr/local/bin/app
ENV SRC_PATH /var/www/application
ENV START_MESSAGE Application has been installed
ENV LOCK_FILE_PATH /tmp/application.lock

ADD ./docker/ApiApplication/config/www.conf /usr/local/etc/php-fpm.d/www.conf

WORKDIR $SRC_PATH

COPY ./docker/ApiApplication/bin $APP_BIN_PATH/
COPY ./ $SRC_PATH

RUN chmod -R +x $APP_BIN_PATH/*

RUN $APP_BIN_PATH/$RUN_MODE/install.sh

CMD $APP_BIN_PATH/$RUN_MODE/run.sh
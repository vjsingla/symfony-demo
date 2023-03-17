FROM nginx:1.9
COPY ./docker/WebserverApiApplication/default.conf /etc/nginx/conf.d/default.conf
WORKDIR /var/www/application
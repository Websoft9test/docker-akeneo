# refer to: https://github.com/chandrantwins/akeneo-docker/blob/master/Dockerfile

FROM akeneo/pim-php-base:latest

RUN apt update -y && apt install apache2 -y

RUN a2enmod actions alias expires headers rewrite proxy_fcgi ssl
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ADD docker/000-default.conf /etc/apache2/sites-available/000-default.conf
ADD docker/php.ini /etc/php/7.2/cli/php.ini
ADD docker/php.ini /etc/php/7.2/fpm/php.ini
ADD docker/entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

WORKDIR /var/www/html
RUN chown -R www-data:www-data /var/www

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

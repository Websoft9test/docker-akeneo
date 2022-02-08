# refer to: https://github.com/chandrantwins/akeneo-docker/blob/master/Dockerfile


FROM akeneo/pim-php-base:master

LABEL maintainer="help@websoft9.com"
LABEL version="latest"
LABEL description="Akeneo"

ENV AKENEO_MYSQL_HOST=mysql
ENV AKENEO_MYSQL_PORT=3306
ENV AKENEO_MYSQL_USER=akeneo
ENV AKENEO_MYSQL_PASSWORD=akeneo
ENV AKENEO_MYSQL_DATABASE=akeneo


RUN apt update -y && apt install apache2 unzip make -y
RUN apt clean && rm -rf /var/lib/apt/lists/*
RUN a2enmod rewrite proxy_fcgi actions alias expires headers ssl
ADD 000-default.conf /etc/apache2/sites-available/000-default.conf
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh && apt install nodejs
RUN wget https://getcomposer.org/composer-stable.phar -O composer.phar; chmod 750 composer.phar;  mv composer.phar /usr/local/bin/composer
RUN rm -rf /var/www/html/*
RUN COMPOSER_MEMORY_LIMIT=-1 composer create-project akeneo/pim-community-standard /var/www/html "5.0.*@stable"

WORKDIR /var/www/html
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

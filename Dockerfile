FROM birdsystem/app
MAINTAINER Allan Sun <allan.sun@bricre.com>

ENV APP_ENVIRONMENT=development

WORKDIR /var/www/back

RUN apt-get update && apt-get -yq install --no-install-recommends \
    php7.0-xdebug php7.0-mbstring telnet net-tools host git wget && \
    a2enmod headers && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# php.ini settings
COPY    php.development.ini /etc/php/7.0/php.development.ini
ADD     ApacheConfig.development.conf /etc/apache2/sites-enabled/000-default.conf

RUN     ln -s /etc/php/7.0/php.development.ini /etc/php/7.0/cli/conf.d/99-php_extra.ini && \
        ln -s /etc/php/7.0/php.development.ini /etc/php/7.0/apache2/conf.d/99-php_extra.ini

ADD run.composer.installer.sh run.composer.installer.sh
RUN sh run.composer.installer.sh && chmod a+x composer.phar && mv composer.phar /usr/local/bin/composer
RUN rm run.composer.installer.sh

ADD run.worker.sh /etc/service/phpworker/run
RUN chmod +x /etc/service/phpworker/run

RUN mkdir -p /etc/my_init.d
ADD run.composer.sh /etc/my_init.d/run.composer.sh
RUN chmod +x /etc/my_init.d/run.composer.sh
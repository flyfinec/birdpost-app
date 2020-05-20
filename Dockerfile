FROM birdsystem/app
MAINTAINER Allan Sun <allan.sun@bricre.com>

ENV APP_ENVIRONMENT=development

WORKDIR /var/www/back

RUN apt-get update && apt-get -yq install --no-install-recommends \
    php7.0-xdebug php7.0-mbstring telnet net-tools host git wget && \
    a2enmod headers && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

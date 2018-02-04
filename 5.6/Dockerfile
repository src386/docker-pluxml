# php-fpm
#
FROM php:7.2-apache

# default ARG(s)
#
ARG pluxml__version=5.6
ARG pluxml__git=https://github.com/pluxml/PluXml
ARG plxtoolbar__git=https://github.com/Pluxopolis/plxtoolbar
ARG plxmycontact__git=https://github.com/Pluxopolis/plxMyContact

# Enable apache mod_rewrite
#
RUN a2enmod rewrite

# Build php extensions
#
RUN set -xe; \
    \
    deps=' \
        libfreetype6 \
        libjpeg62-turbo \
        libpng16-16 \
    '; \
    buildDeps=' \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    '; \
    apt-get update; \
    apt-get install -y --no-install-recommends $deps; \
    apt-get install -y --no-install-recommends $buildDeps; \
    rm -rf /var/lib/apt/lists/*; \
    \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/; \
    docker-php-ext-install -j$(nproc) gd; \
    \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $buildDeps

# Clone pluxml, pluxtoolbar and plxmycontact
#
RUN set -xe; \
    \
    fetchDeps=' \
        git \
    '; \
    apt-get update; \
    apt-get install -y --no-install-recommends $fetchDeps; \
    rm -rf /var/lib/apt/lists/*; \
    \
    git clone -b $pluxml__version --single-branch --depth 1 $pluxml__git /var/www/html; \
    git clone $plxtoolbar__git /var/www/html/plugins/plxtoolbar; \
    git clone $plxmycontact__git /var/www/html/plugins/plxMyContact; \
    mv /var/www/html/data /var/www/html/data.defaults; \
    chown -R www-data: /var/www/html; \
    \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $fetchDeps

# Install ssmtp to send e-mail through a relay
#
RUN set -xe; \
    \
    smtpDeps=' \
        ssmtp \
    '; \
    apt-get update; \
    apt-get install -y --no-install-recommends $smtpDeps; \
    rm -rf /var/lib/apt/lists/*

VOLUME /var/www/html/data

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

# Inherited
# 
# EXPOSE 80
CMD ["apache2-foreground"]

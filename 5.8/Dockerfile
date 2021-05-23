# docker-pluxml
#
FROM php:7.4-apache

# default ARG(s)
#
ARG pluxml__version=v5.8.6
ARG pluxml__git=https://github.com/pluxml/PluXml
ARG plxtoolbar__git=https://github.com/Pluxopolis/plxtoolbar
ARG plxmycontact__git=https://github.com/Pluxopolis/plxMyContact

# Enable apache mod_rewrite and remoteip
#
RUN set -xe; \
    a2enmod rewrite; \
    a2enmod remoteip

# Configure remoteip, a2enconf done later by docker-entrypoint if REMOTEIP_ENABLE=true
#
RUN set -eux; \
    { \
        echo '# Allow Private IPv4 address spaces'; \ 
        echo 'RemoteIPHeader X-Forwarded-For'; \
        echo 'RemoteIPTrustedProxy 10.0.0.0/8'; \
        echo 'RemoteIPTrustedProxy 172.16.0.0/12'; \
        echo 'RemoteIPTrustedProxy 192.168.0.0/16'; \
        echo '# Override logging options'; \
        echo 'LogFormat "%v:%p %a %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"" vhost_combined'; \
        echo 'LogFormat "%a %l %u %t \"%r\" %>s %O \"%{Referer}i\" \"%{User-Agent}i\"" combined'; \
        echo 'LogFormat "%a %l %u %t \"%r\" %>s %O" common'; \
    } > /etc/apache2/conf-available/remoteip.conf

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
    docker-php-ext-configure gd --with-freetype --with-jpeg; \
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
        msmtp \
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

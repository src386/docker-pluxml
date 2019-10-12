#!/bin/bash
#

# What this script does:
# - Check if pluxml data is present. If not, it needs to be created with default directory layout.
# - Check if pluxml data needs an upgrade (if core > data).
# - Check if PHP_TIMEZONE is defined and set it 
# - Check if PHP_UPLOAD_MAXSIZE is defined and set it
# - Check if PHP_SMTP_HOST and configure smtp for php
# - Check if ENABLE_REMOTEIP is true and a2enconf remoteip
# - Configure /etc/msmtprc with SMTP parameters

# Detect if PluXml has existing data
if [ ! -e "/var/www/html/data/configuration/parametres.xml" ]; then
    echo "No data found in /var/www/html/data - Installing PluXml"
    cp -R /var/www/html/data.defaults/* /var/www/html/data
    chown -R www-data: /var/www/html/data
else
    echo "Data found - Checking version"
        plx__version="$(grep 'PLX_VERSION' /var/www/html/core/lib/config.php | cut -d "'" -f 4)"
        plx__installed="$(grep '"version"' /var/www/html/data/configuration/parametres.xml  | cut -f 2 -d ">" | cut -f 1 -d "<" )"
        if [ "$plx__version" -gt "$plx__installed" ]; then
            echo "Data upgrade is available"
            echo "install.php will not be removed"
        elif [ "$plx__version" -lt "$plx__installed" ]; then
            echo "Woops, this blog has been created with a newer version of PluXml"
            echo "Expect trouble..."
        else
            echo "Already up-to-date"
            echo "install.php will be removed"
            rm /var/www/html/install.php
        fi
fi

# Set date.timezone if PHP_TIMEZONE is defined
if [ -z ${PHP_TIMEZONE+x} ]; then
    echo "PHP_TIMEZONE not set. Ignoring..."
else
    echo "PHP_TIMEZONE set to ${PHP_TIMEZONE}, adding in php configuration..."
    cat > /usr/local/etc/php/conf.d/docker-php-timezone.ini <<-EOF
	date.timezone = "${PHP_TIMEZONE}"
	EOF
    # Do not indent EOF with spaces, <<-EOF works with TAB
fi

# Set post_max_size and upload_max_filesize if PHP_UPLOAD_MAXSIZE is defined
if [ -z ${PHP_UPLOAD_MAXSIZE+x} ]; then
    echo "PHP_UPLOAD_MAXSIZE not set. Ignoring..."
else
    echo "PHP_UPLOAD_MAXSIZE set to ${PHP_UPLOAD_MAXSIZE}, adding in php configuration..."
    upload_max_filesize="${PHP_UPLOAD_MAXSIZE//[!0-9]/}" # remove non-numeric characters
    post_max_size=$(($upload_max_filesize * 2)) # set post_max_size to upload_max_size x2
    cat > /usr/local/etc/php/conf.d/docker-php-max-filesize.ini <<-EOF
	post_max_size = ${post_max_size}M
	upload_max_filesize = ${upload_max_filesize}M
	EOF
    # Do not indent EOF with spaces, <<-EOF works with TAB
fi

# Enable remoteip module if ENABLE_REMOTEIP is true
if [ "${ENABLE_REMOTEIP}" = true ] ; then
    a2enconf remoteip
fi

# Set /etc/msmtprc and sendmail_path if PHP_SMTP_HOST is defined
if [ -z ${PHP_SMTP_HOST+x} ]; then
    echo "PHP_SMTP_HOST not set. Ignoring SMTP configuration..."
else
    echo "PHP_SMTP_HOST set to ${PHP_SMTP_HOST}, adding /usr/bin/msmtp in php configuration..."
    cat > /usr/local/etc/php/conf.d/docker-php-smtp.ini <<-EOF
	sendmail_path = "/usr/bin/msmtp -t"
	EOF
    # Do not indent EOF with spaces, <<-EOF works with TAB

    SMTP_HOST=${PHP_SMTP_HOST}
    SMTP_PORT=${PHP_SMTP_PORT:=25} # Set to 25 if undefined
    cat > /etc/msmtprc <<-EOF
    defaults
    
    account default
    host ${SMTP_HOST}
    port ${SMTP_PORT}
    from pluxml
	EOF
    # Do not indent EOF with spaces, <<-EOF works with TAB

    SMTP_USE_TLS=${PHP_SMTP_USE_TLS:=no} # Set to 'no' if undefined
    if [ ${SMTP_USE_TLS} = "yes" ]; then
        echo "SMTP_USE_TLS set to yes, adding parameters in /etc/msmtprc..."
        cat >> /etc/msmtprc <<-EOF
        tls on
        tls_trust_file /etc/ssl/certs/ca-certificates.crt
		EOF
    # Do not indent EOF with spaces, <<-EOF works with TAB
    fi

    if [ -z ${PHP_SMTP_USER+x} ]; then
        echo "PHP_SMTP_USER not set. Ignoring AuthUser and AuthPass configuration..."
    else
        SMTP_USER=${PHP_SMTP_USER}
        SMTP_PASSWORD=${PHP_SMTP_PASSWORD}
        cat  >> /etc/msmtprc <<-EOF
        auth on
        user ${SMTP_USER}
        password ${SMTP_PASSWORD}
		EOF
    fi
fi

exec "$@"

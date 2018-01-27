#!/bin/bash
#

# Check if pluxml data is present and needs to be upgraded.
#

# Functions
#
rm_install.php() {
    rm /var/www/html/install.php
}

copy_default_data() {
    cp -R /var/www/html/data.defaults/* /var/www/html/data
    chown -R www-data: /var/www/html/data
}

if [ ! -e "/var/www/html/data/configuration/parametres.xml" ]; then
    echo "No data found in /var/www/html/data - Installing PluXml"
    copy_default_data
else
    echo "Data found - Check version"
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
            rm_install.php
        fi
fi

exec "$@"

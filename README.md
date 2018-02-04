# [![PluXml logo][pluxml-logo]](http://www.pluxml.org/) docker-pluxml

*A lightweight blog engine powered by PHP and Xml*

[![RSS commits][rss-commits]](https://github.com/src386/docker-pluxml/commits/master.atom)

[pluxml-logo]: https://raw.githubusercontent.com/src386/docker-pluxml/master/lib/images/pluxml-logo-small.png
[rss-commits]: https://img.shields.io/badge/RSS-commits-orange.svg

[PluXml][pluxml] is a lightweight, easy to use opensource CMS/Blog-engine that requires no database. It is portable and can be installed in a standard php web hosting solution. Static pages, tags, media, rss, user management, plugins, url rewriting are supported. It is available in 11 languages.

You can find out more about PluXml features on the [project's website][pluxml] (french).

[pluxml]: http://www.pluxml.org/

## Quick start

Pull the image and fire up a PluXml container:

    docker pull src386/docker-pluxml
    docker run -p 80:80 \
     -v /etc/localtime:/etc/localtime:ro \
     -v data:/var/www/html/data \
     -d src386/docker-pluxml:latest

It is recommend to use a VOLUME for /var/www/html/data (persistent data).

Or, using docker-compose (recommended):

Create a docker-compose.yml file:

    version: '3'
    services:

      pluxml:
        image: src386/docker-pluxml:latest
        ports:
          - "127.0.0.1:80:80"
        volumes:
          - /etc/localtime:/etc/localtime:ro
          - data:/var/www/html/data

    volumes:
      data:

It is recommended to use a VOLUME for /var/www/html/data (persistent data).

Then fire up a PluXml container:

    docker-compose up -d

Features
--------

- Image currently based on php:7.2-apache
- Plugins: plxtoolbar (unofficial wysiwyg editor for PluXml) and plxmycontact (contact form)
- Handles upgrades 

Development
-----------

For example if you want to build the 5.6 image:

    git clone https://github.com/src386/docker-pluxml
    cd docker-pluxml/5.6 && docker build -t docker-pluxml:5.6 .

Or you may want to use the docker-compose.yml file:

    git clone https://github.com/src386/docker-pluxml
    cd docker-pluxml/5.6 && docker-compose build

Upgrades
--------

Pull the new image then restart your containers.
The image uses a `docker-entrypoint.sh` script that handles data upgrades.

Configuration
-------------

List of environment variables:

- **PHP_TIMEZONE**: Set `date.timezone` for PHP (default to none/UTC)
- **PHP_UPLOAD_MAXSIZE**: Set `upload_max_filesize` (default 2M)  and `post_max_size`
- **PHP_SMTP_RELAY**: *Work in progress*

Example:

    docker run \
    -p 80:80 \
    -v /etc/localtime:/etc/localtime:ro \
    -v data:/var/www/html/data \
    -e PHP_TIMEZONE=Europe/Paris \
    -e PHP_UPLOAD_MAXSIZE=8M \ 
    -d src386/docker-pluxml:latest

Or, using docker-compose:

    version: '3'
    services:

      pluxml:
        image: src386/docker-pluxml:latest
        ports:
          - "127.0.0.1:80:80"
        volumes:
          - /etc/localtime:/etc/localtime:ro
          - data:/var/www/html/data
        environment:
          - PHP_TIMEZONE=Europe/Paris
          - PHP_UPLOAD_MAXSIZE=8M

    volumes:
      data:

## Licensing

Since PluXml is under [GNU General Public License][gnugpl], docker-pluxml too.
You can find full text of the license in the [LICENSE][license] file.

[gnugpl]: http://www.gnu.org/licenses/gpl.html
[license]: https://github.com/src386/docker-pluxml/blob/master/LICENSE

# [![PluXml logo][pluxml-logo]](http://www.pluxml.org/) docker-pluxml

*A lightweight blog engine powered by PHP and Xml.*

[![Travis CI][travis-ci]](https://travis-ci.org/src386/docker-pluxml)
[![RSS commits][rss-commits]](https://github.com/src386/docker-pluxml/commits/master.atom)

[pluxml-logo]: https://raw.githubusercontent.com/src386/docker-pluxml/master/lib/images/pluxml-logo-small.png
[travis-ci]: https://img.shields.io/travis/src386/docker-pluxml.svg?style=flat
[rss-commits]: https://img.shields.io/badge/RSS-commits-orange.svg

[PluXml][pluxml] is a lightweight, easy to use opensource CMS/Blog-engine that requires no database. It is portable and can be installed in a standard php web hosting solution. Static pages, tags, media, rss, user management, plugins, url rewriting are supported. It is available in 11 languages.

You can find out more about PluXml features on the [project's website][pluxml] (french).

[pluxml]: http://www.pluxml.org/

## Supported tags and respective `Dockerfile` links

- [`5.7`][dockerfile-5.7], [`latest`][dockerfile-latest] ([5.7/Dockerfile][dockerfile-5.7])
- [`5.6`][dockerfile-5.6] ([5.6/Dockerfile][dockerfile-5.6])

[dockerfile-latest]: https://github.com/src386/docker-pluxml/blob/master/5.7/Dockerfile
[dockerfile-5.67]: https://github.com/src386/docker-pluxml/blob/master/5.7/Dockerfile
[dockerfile-5.6]: https://github.com/src386/docker-pluxml/blob/master/5.6/Dockerfile

## Quick start

Pull the image and fire up a PluXml container:

    docker pull src386/docker-pluxml
    docker run -p 80:80 \
     -v data:/var/www/html/data \
     -d src386/docker-pluxml:latest

It is recommend to use a VOLUME for /var/www/html/data (persistent data).

Or, using docker-compose (recommended):

    version: '3'
    services:

      pluxml:
        image: src386/docker-pluxml:latest
        ports:
          - "127.0.0.1:80:80"
        volumes:
          - data:/var/www/html/data

    volumes:
      data:

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

List of (optionnal) environment variables:

- PHP_TIMEZONE: Set `date.timezone` for PHP (default: none/UTC)
- PHP_UPLOAD_MAXSIZE: Set `upload_max_filesize` (default: 2M)  and `post_max_size`
- PHP_SMTP_HOST: ip or hostname
- PHP_SMTP_PORT: (default: 25)
- PHP_SMTP_USER: (default: blank)
- PHP_SMTP_PASSWORD: (default: blank)
- PHP_SMTP_USE_TLS: set to **yes** to use TLS connnection (default: none)
- ENABLE_REMOTEIP: set to **true** to log client real IP / X-Forwarded-For when using a load-balancer/reverse-proxy. Please consider reading the [mod_remoteip][mod_remoteip] documentation to understand how proxies are trusted. In order to easily work in a Docker container, mod_remoteip will trust [Private IPv4][ipv4spaces] address spaces.

[mod_remoteip]: https://httpd.apache.org/docs/2.4/en/mod/mod_remoteip.html
[ipv4spaces]: https://en.wikipedia.org/wiki/Private_network#Private_IPv4_address_spaces

Full example:

    docker run \
    -p 80:80 \
    -v /etc/localtime:/etc/localtime:ro \
    -v data:/var/www/html/data \
    -e PHP_TIMEZONE=Europe/Paris \
    -e PHP_UPLOAD_MAXSIZE=8M \ 
    -e PHP_SMTP_HOST=1.2.3.4 \
    -e PHP_SMTP_PORT=25 \
    -e PHP_SMTP_USER=john \
    -e PHP_SMTP_PASSWORD=secret \
    -e PHP_SMTP_USE_TLS=yes \
    -e ENABLE_REMOTEIP=true \
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
         - PHP_SMTP_HOST=1.2.3.4
         - PHP_SMTP_PORT=25
         - PHP_SMTP_USER=john
         - PHP_SMTP_PASSWORD=secret
         - PHP_SMTP_USE_TLS=yes
         - ENABLE_REMOTEIP=true

    volumes:
      data:

## FAQ

### How do I delete install.php ?

Restart the container. If install.php is still present, open an issue.

### What about HTTPS support ?

I will **not** implement https support. Use nginx or haproxy as a reverse proxy and SSL offloader.

## Licensing

Since PluXml is under [GNU General Public License][gnugpl], docker-pluxml too.
You can find full text of the license in the [LICENSE][license] file.

[gnugpl]: http://www.gnu.org/licenses/gpl.html
[license]: https://github.com/src386/docker-pluxml/blob/master/LICENSE

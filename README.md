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
    docker run --name pluxml -p 80:80 -v data:/var/www/html/data -d src386/docker-pluxml:latest

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
          - /etc/localtime:/etc/localtime
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

If you want to build the image:

    git clone https://github.com/src386/docker-pluxml
    cd docker-pluxml && docker build -t docker-pluxml:latest .

Or you may want to use the docker-compose.yml file:

    git clone https://github.com/src386/docker-pluxml
    docker-compose build

Upgrades
--------

Use docker-compose (recommended):

    cd docker-pluxml && git pull
    docker-compose build --pull
    docker-compose up -d

A pre-build Dockerhub image is coming soon.

Configuration
-------------

Coming soon:

- upload_max_filesize
- timezone
- smtp

## Licensing

Since PluXml is under [GNU General Public License][gnugpl], docker-pluxml too.
You can find full text of the license in the [LICENSE][license] file.

[gnugpl]: http://www.gnu.org/licenses/gpl.html
[license]: https://github.com/src386/docker-pluxml/blob/master/LICENSE

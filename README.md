# [![PluXml logo][pluxml-logo]](http://www.pluxml.org/) docker-pluxml

*A lightweight blog engine powered by PHP and Xml*

[![RSS commits][rss-commits]](https://github.com/src386/docker-pluxml/commits/master.atom)

[pluxml-logo]: https://raw.githubusercontent.com/src386/docker-pluxml/master/lib/images/pluxml-logo-small.png
[rss-commits]: https://img.shields.io/badge/RSS-commits-orange.svg

[PluXml][pluxml] is a lightweight, easy to use opensource CMS/Blog-engine that requires no database. It is portable and can be installed in a standard php web hosting solution. Static pages, tags, media, rss, user management, plugins, url rewriting are supported. It is available in 11 languages.

You can find out more about PluXml features on the [project's website][pluxml] (french).

[pluxml]: http://www.pluxml.org/

## Quick start

Clone this repository, build the image and fire up a PluXml container:

    git clone https://github.com/src386/docker-pluxml
    cd docker-pluxml && docker build -t pluxml .
    docker run --publish 80:80 --name pluxml --detach pluxml

Or, use docker-compose (recommended):

    git clone https://github.com/src386/docker-pluxml
    cd docker-pluxml && docker-compose up -d

A pre-built Dockerhub image is coming soon.

Features
--------

- Image currently based on php:7.2-apache
- Plugins: plxtoolbar (unofficial wysiwyg editor for PluXml) and plxmycontact (contact form)
- Handles upgrades 

Upgrades
--------

Upgrades should be easy, docker-pluxml has a `docker-entrypoint.sh` script that handles everything.
Just pull the git repo, rebuild and restart your container:

    cd docker-pluxml && git pull
    docker build -t pluxml .
    docker stop pluxml
    docker run --publish 80:80 --name pluxml --detach pluxml

Or, use docker-compose (recommended):

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

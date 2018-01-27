# docker-pluxml

PluXml is a lightweight blog engine powered by Xml (no database).

# Run with docker-compose (RECOMMENDED)

Clone:

```bash
$ git clone https://github.com/src386/docker-pluxml
```

Build and run:

```bash
$ cd docker-pluxml
$ docker-compose up -d
```

# Upgrade

```bash
$ cd docker-pluxml
$ docker-compose build --pull
$ docker-compose up -d
```

# About

- Image based on php:7.2-apache
- plxtoolbar (unofficial wysiwyg plyxml editor)
- plxmycontact (smtp support TODO)
- install.php is removed, unless new install or upgrade

# Misc

TODO

- upload_max_filesize
- timezone
- ssmtp

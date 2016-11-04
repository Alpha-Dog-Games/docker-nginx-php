Table of Contents
-------------------

 * [Installation](#installation)
 * [Quick Start](#quick-start)
 * [Persistence](#developmentpersistence)
 * [Linked to other container](#linked-to-other-container)
 * [Adding PHP-extension](#adding-php-extension) 
 * [Logging](#logging)
 * [Out of the box](#out-of-the-box)

Installation
-------------------

 * [Install Docker 1.9+](https://docs.docker.com/installation/) or [askubuntu](http://askubuntu.com/a/473720)
 * Pull the latest version of the image.
 
```bash
docker pull alphadoggames/nginx-php-5.6
```
Alternately you can build the image yourself.

```bash
docker build -t alphadoggames/nginx-php-5.6 .
```

Quick Start
-------------------

Run the application container:

```bash
docker run --name app -d -p 8080:80 alphadoggames/nginx-php-5.6
```

The simplest way to login to the app container is to use the `docker exec` command to attach a new process to the running container.

```bash
docker exec -it app bash
```

Development/Persistence
-------------------

For development a volume should be mounted at `/var/www/app/`.

The updated run command looks like this.

```bash
docker run --name app -d -p 8080:80 \
  -v /host/to/path/app:/var/www/app/ \
  alphadoggames/nginx-php-5.6
```

This will make the development.

Linked to other container
-------------------

As an example, will link with RDBMS PostgreSQL. 

```bash
docker network create pg_net

docker run --name db -d --net pg_net romeoz/docker-postgresql
```

Run the application container:

```bash
docker run --name app -d -p 8080:80 \
  --net pg_net \
  -v /host/to/path/app:/var/www/app/ \
  alphadoggames/nginx-php-5.6
```

Adding PHP-extension
-------------------

You can use one of two choices to install the required php-extensions:

1. `docker exec -it app bash -c 'apt-get update && apt-get install php-mongo && rm -rf /var/lib/apt/lists/*'`

2. Create your container on based the current. Сontents Dockerfile:

```
FROM alphadoggames/nginx-php-5.6

RUN apt-get update \
    && apt-get install -y php-mongo \
    && rm -rf /var/lib/apt/lists/* 

WORKDIR /var/www/app/

EXPOSE 80 443

CMD ["/usr/bin/supervisord"]
```

Next step,

```bash
docker build -t alphadoggames/nginx-php-5.6 .
docker run --name app -d -p 8080:80 alphadoggames/nginx-php-5.6
```

>See installed php-extension: `docker exec -it app php -m`

Logging
-------------------

All the logs are forwarded to stdout and sterr. You have use the command `docker logs`.

```bash
docker logs app
```

####Split the logs

You can then simply split the stdout & stderr of the container by piping the separate streams and send them to files:

```bash
docker logs app > stdout.log 2>stderr.log
cat stdout.log
cat stderr.log
```

or split stdout and error to host stdout:

```bash
docker logs app > -
docker logs app 2> -
```

####Rotate logs

Create the file `/etc/logrotate.d/docker-containers` with the following text inside:

```
/var/lib/docker/containers/*/*.log {
    rotate 31
    daily
    nocompress
    missingok
    notifempty
    copytruncate
}
```
> Optionally, you can replace `nocompress` to `compress` and change the number of days.

Out of the box
-------------------
 * Ubuntu 12.04, 14.04 or 16.04 LTS
 * Nginx 1.10
 * PHP 5.3, 5.4, 5.5, 5.6, 7.0 or 7.1
 * Composer (package manager)

>Environment depends on the version of PHP.

License
-------------------

Nginx + PHP-FPM docker image is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT)
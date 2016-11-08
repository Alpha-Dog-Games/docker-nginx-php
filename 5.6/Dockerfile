FROM alphadoggames/phpfpm-5.6
MAINTAINER George Hornmoen <george@alphadoggames.com>

ENV OS_LOCALE="en_US.UTF-8"
RUN locale-gen ${OS_LOCALE}
ENV LANG=${OS_LOCALE} \
	LANGUAGE=en_US:en \
	LC_ALL=${OS_LOCALE} \
	NGINX_CONF_DIR=/etc/nginx \
	APP_WORK_DIR=/var/www/monstrocity/

COPY ./supervisord.conf /etc/supervisor/conf.d/

RUN	\
	buildDeps='software-properties-common python-software-properties wget' \
	&& apt-get update \
	&& apt-get install --no-install-recommends -y $buildDeps \
    && wget -O - http://nginx.org/keys/nginx_signing.key | apt-key add - \
	&& echo "deb http://nginx.org/packages/ubuntu/ xenial nginx" | tee -a /etc/apt/sources.list \
	&& echo "deb-src http://nginx.org/packages/ubuntu/ xenial nginx" | tee -a /etc/apt/sources.list \
	&& apt-get update \
	&& apt-get install -y nginx \
	&& rm -rf  ${NGINX_CONF_DIR}/sites-enabled/* ${NGINX_CONF_DIR}/sites-available/* \
	# Install supervisor
	&& apt-get install -y supervisor && mkdir -p /var/log/supervisor \
	&& chown www-data:www-data ${APP_WORK_DIR} -Rf \
	# Cleaning
	&& apt-get purge -y --auto-remove $buildDeps \
	&& apt-get autoremove -y && apt-get clean \
	&& rm -rf /var/lib/apt/lists/* \
	# Forward request and error logs to docker log collector
	&& ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

COPY ./configs/nginx.conf ${NGINX_CONF_DIR}/nginx.conf
COPY ./configs/app.conf ${NGINX_CONF_DIR}/sites-enabled/app.conf

RUN chown www-data:www-data ${NGINX_CONF_DIR} -Rf

WORKDIR ${APP_WORK_DIR}

EXPOSE 80 443

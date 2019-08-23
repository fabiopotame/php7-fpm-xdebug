FROM alpine:3.8

LABEL maintainer="Fabio Potame <fabiopotame@gmail.com>"

RUN apk --update add --no-cache php7-fpm php7-pear php7-dev php7-tokenizer php7-mbstring php7-dom build-base ca-certificates composer \
	&& wget https://raw.githubusercontent.com/docker-library/php/master/7.3/alpine3.10/fpm/docker-php-entrypoint -O /usr/local/bin/docker-php-entrypoint \
	&& wget https://raw.githubusercontent.com/docker-library/php/master/7.3/alpine3.10/fpm/docker-php-ext-configure -O /usr/local/bin/docker-php-ext-configure \
	&& wget https://raw.githubusercontent.com/docker-library/php/master/7.3/alpine3.10/fpm/docker-php-ext-install -O /usr/local/bin/docker-php-ext-install \
	&& wget https://raw.githubusercontent.com/docker-library/php/master/7.3/alpine3.10/fpm/docker-php-source -O /usr/local/bin/docker-php-source \
	&& wget https://raw.githubusercontent.com/docker-library/php/master/7.3/alpine3.10/fpm/docker-php-ext-enable -O /usr/local/bin/docker-php-ext-enable \
	&& wget http://pecl.php.net/get/xdebug-2.7.2.tgz -O /tmp/xdebug-2.7.2.tgz \
	&& mkdir -p /usr/src && wget https://www.php.net/distributions/php-7.1.30.tar.xz -O /usr/src/php.tar.xz \
	&& chmod 751 -R /usr/local/bin/docker-php-* && ln -s /etc/php7/conf.d/ /conf.d \
	&& pecl config-set php_ini /etc/php7/php.ini \
	&& pecl install /tmp/xdebug-2.7.2.tgz \
	&& docker-php-ext-enable xdebug \
	&& echo "xdebug.remote_enable=on" >> /etc/php7/conf.d/xdebug.ini \
	&& echo "xdebug.remote_autostart=off" >> /etc/php7/conf.d/xdebug.ini \
	&& docker-php-ext-install json \
	&& rm -f /usr/src/php.tar.xz \
	&& rm -f /tmp/xdebug-2.7.2.tgz

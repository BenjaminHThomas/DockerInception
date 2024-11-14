FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install -y \
	wget \ 
	curl \
	bash \
	php7.4 \
	php7.4-cgi \
	php7.4-mysql \
	php7.4-fpm \
	php7.4-pdo \
	php7.4-gd \ 
	php7.4-cli \
	php7.4-mbstring \
	default-mysql-client && \
	php-fpm7.4 --version

RUN sed -i 's|^listen = /run/php/php7.4-fpm.sock|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir -p /var/www/html/wordpress && \
	chmod -R 755 /var/www/html/wordpress && \
	chown -R www-data:www-data /var/www/html/wordpress && \
	mkdir -p /run/php

WORKDIR /var/www/html/wordpress

COPY ./script.sh /usr/local/bin/wp_config.sh
RUN chmod +x /usr/local/bin/wp_config.sh

EXPOSE 9000

CMD ["/usr/local/bin/wp_config.sh"]

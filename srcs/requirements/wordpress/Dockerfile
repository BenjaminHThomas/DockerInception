FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

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
	&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/php

COPY www.conf /etc/php/7.4/fpm/pool.d/.
COPY script.sh .
RUN chmod +x script.sh

EXPOSE 9000

CMD ["./script.sh"]

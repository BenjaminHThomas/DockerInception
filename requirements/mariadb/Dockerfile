FROM debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y && apt install -y \
	gnupg \
	lsb-release \
	wget \
	mariadb-server \
	mariadb-client \
	&& rm -rf /var/lib/apt/lists/*

RUN sed -i 's/^bind-address\s*=.*$/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

ENV MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASS}
ENV MYSQL_DATABASE=${MYSQL_DB}
ENV MYSQL_USER=${MYSQL_USER}
ENV MYSQL_PASSWORD=${MYSQL_PASS}

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/.
COPY init.sql /etc/mysql/init.sql

RUN mkdir /run/mysqld

CMD ["mysqld"]

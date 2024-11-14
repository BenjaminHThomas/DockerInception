#!/bin/bash
set -eo pipefail

if [ ! -d "/var/lib/mysql/is_init" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    # Start mariadb without networking
    mysqld --user=mysql --skip-networking &
    pid="$!"

    # Wait until the mariadb server is ready
    until mysqladmin ping -h"localhost" --silent; do
        echo "Waiting for MariaDB to be ready..."
        sleep 1
    done

    mysql -e "FLUSH PRIVILEGES;"
    mysql -e "CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASS}';"
    mysql -e "ALTER USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASS}';"
    mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
    mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
    mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"
    mysql -e "FLUSH PRIVILEGES;"

    # Shutdown initial mariadb instance
    mysqladmin -uroot -p${MYSQL_ROOT_PASS} shutdown
    echo "done" > /var/lib/mysql/is_init
    wait "$pid"
fi

# Start the mysql server
exec gosu mysql "$@"

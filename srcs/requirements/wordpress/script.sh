#!/bin/bash

# Wait for Redis to be ready
while ! nc -z redis 6379; do
    echo "Waiting for Redis..."
    sleep 1
done

wp core download  
wp config create --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --dbhost=mariadb  
wp config set WP_CACHE true --raw  
wp config set WP_DEBUG true --raw  
wp config set WP_REDIS_HOST redis --allow-root
wp config set WP_REDIS_PORT 6379 --allow-root

until wp db check --allow-root do
    echo "Waiting for database..."
    sleep 1
done

wp core install --url="$WORDPRESS_SITE_URL" --title="$WORDPRESS_SITE_TITLE" --admin_user="$WORDPRESS_ADM_USER" --admin_password="$WORDPRESS_ADM_PASS" --admin_email="$WORDPRESS_ADMIN_EMAIL"  
wp plugin install redis-cache --activate --allow-root
wp redis enable --allow-root
wp user create "${WORDPRESS_USERNAME}" "${WORDPRESS_EMAIL}" --user_pass="${WORDPRESS_PASS}" --role=subscriber  
chown -R www-data:www-data ./wp-content
chmod -R 777 ./wp-content && \


php-fpm7.4 -F
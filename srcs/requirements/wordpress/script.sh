#!/bin/bash
curl -L -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
chmod +x wp-cli.phar && \
mv ./wp-cli.phar /bin/wp

wp core download  --allow-root
wp config create --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --dbhost=mariadb  --allow-root
wp config set WP_CACHE true --raw  --allow-root
wp config set WP_DEBUG true --raw  --allow-root
wp config set WP_REDIS_HOST redis --allow-root
wp config set WP_REDIS_PORT 6379 --allow-root

until wp db check --allow-root; do
    echo "Waiting on mariadb..."
    sleep 3
done

wp core install --url="$WORDPRESS_SITE_URL" --title="$WORDPRESS_SITE_TITLE" --admin_user="$WORDPRESS_ADM_USER" \
    --admin_password="$WORDPRESS_ADM_PASS" \
    --admin_email="$WORDPRESS_ADMIN_EMAIL" \
    --skip-email --allow-root
wp theme install astra --activate --allow-root
wp plugin install redis-cache --activate --allow-root
wp redis enable --allow-root
wp user create "${WORDPRESS_USERNAME}" "${WORDPRESS_EMAIL}" --user_pass="${WORDPRESS_PASS}" --role=subscriber --allow-root
chown -R www-data:www-data ./wp-content
chmod -R 777 ./wp-content

exec php-fpm7.4 -F -R
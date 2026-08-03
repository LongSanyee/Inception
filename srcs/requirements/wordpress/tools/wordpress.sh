#!/bin/bash

while ! mysql -h mariadb -u ${MYSQL_USER} -p${MYSQL_PASSWORD} -e "SELECT 1;" >/dev/null 2>&1; do
    sleep 2
done

cd /var/www/html

if [ ! -f "wp-config.php" ]; then
    wp core download --allow-root
    
    wp config create \
        --dbname=${MYSQL_DB} \
        --dbuser=${MYSQL_USER} \
        --dbpass=${MYSQL_PASSWORD} \
        --dbhost=mariadb:3306 \
        --allow-root

    wp core install \
        --url=${DOMAIN_NAME} \
        --title="Inception" \
        --admin_user=${WP_ADMIN_USER} \
        --admin_password=${WP_ADMIN_PWD} \
        --admin_email=${WP_ADMIN_MAIL} \
        --allow-root

    wp user create \
        ${WP_USER} \
        ${WP_USER_MAIL} \
        --user_pass=${WP_USER_PWD} \
        --role=author \
        --allow-root

    chown -R www-data:www-data /var/www/html
fi

exec /usr/sbin/php-fpm8.2 -F
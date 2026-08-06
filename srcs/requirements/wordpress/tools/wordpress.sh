#!/bin/bash

cd /var/www/html

if [ ! -f "wp-config.php" ]; then
    
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

fi

exec /usr/sbin/php-fpm8.2 -F
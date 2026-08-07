#!/bin/sh


if [ ! -f "/etc/nginx/ssl" ]; then
    mkdir -p /etc/nginx/ssl

    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/inception.key \
        -out /etc/nginx/ssl/inception.crt \
        -subj "/CN=rammisse.42.fr"
fi

exec nginx -g "daemon off;"
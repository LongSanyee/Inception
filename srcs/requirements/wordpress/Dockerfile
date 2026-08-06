FROM debian:bookworm

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        php8.2-fpm \
        php8.2-mysql \
        wget \
        ca-certificates \
        mariadb-client

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/html && \
    cd /var/www/html && \
    wp core download --allow-root

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

COPY tools/wordpress.sh /usr/local/bin/wordpress.sh
RUN chmod +x /usr/local/bin/wordpress.sh

RUN mkdir -p /run/php

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wordpress.sh"]
FROM debian:bullseye

# Install PHP-FPM, MySQL extension, and dependencies for WP-CLI
RUN apt-get update -y && \
    apt-get install -y \
    php7.4-fpm \
    php7.4-mysql \
    mariadb-client \
    curl \
    wget && \
    rm -rf /var/lib/apt/lists/*

# Download and install WP-CLI executable
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Create web directory and PHP run directory
RUN mkdir -p /var/www/html /run/php

# Configure PHP-FPM to listen on 0.0.0.0:9000 instead of unix socket
RUN sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 0.0.0.0:9000|' /etc/php/7.4/fpm/pool.d/www.conf

# Copy entrypoint script
COPY tools/wordpress.sh /usr/local/bin/wordpress.sh
RUN chmod +x /usr/local/bin/wordpress.sh

WORKDIR /var/www/html

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/wordpress.sh"]
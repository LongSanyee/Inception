#!/bin/bash

if [ ! -d "/var/lib/mysql/$MYSQL_DB" ]; then
    
    echo "First boot detected. Initializing database..."

    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
    mysqld_safe --datadir=/var/lib/mysql &

    sleep 5

    mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB}\`;"
    mysql -u root -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -u root -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DB}\`.* TO '${MYSQL_USER}'@'%';"
    mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

    mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
    
    echo "Database setup complete."
else
    echo "Database already exists. Skipping initialization."
fi

echo "Starting MariaDB in the foreground..."
exec mysqld_safe --datadir=/var/lib/mysql
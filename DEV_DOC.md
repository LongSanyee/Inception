# Developer documentation: Inception

This document provides a comprehensive guide for developers to set up, build, launch, and manage the Inception project architecture.

## 1.How to set up the enviroment
Create a .env file inside the srcs directory and populate them with the following variables:
{
    DOMAIN_NAME=login,42.fr

    MYSQL_DB=wordpress
    MYSQL_USER=exampleuser
    MYSQL_PASSWORD=examplepwd
    MYSQL_ROOT_PASSWORD=examplerootpwd

    WP_ADMIN_USER=examplesuper
    WP_ADMIN_PWD=examplepwdsuper
    WP_ADMIN_MAIL=exampleemail@mail.com

    WP_USER=exampleuser
    WP_USER_PWD=examplepwd
    WP_USER_MAIL=examplemail@mail.com
}

## 2.Routing traffic to the correct nginx virtual host
Open /etc/hosts as root and add the following line:
127.0.0.1  login.42.fr

## 3.Host Directories
Where the project data is stored in our host machine:
/home/login/mariadb
/home/login/wordpress

## 4.Build and launch
The project is built using a Makefile utilizing Docker-Compose

To build the images from scratch and start the containers open a terminal to the root of the repository and run:
make

What happens behind the scenes:
1. Makefile ensures the data directories are created
2. docker-compose up -d --build is executed
3. Docker builds the images of our 3 sevices according to their Dockerfiles
4. services are started in the correct dependency order (Mariadb -> Wordpress -> Nginx) using health checks
5. Setup scripts copied from the host machine are executed inside their respective container

Once the make command finishes you can verify the site is accessible by navigating to:
https://login.42.fr

## 5.Commands to manage Containers and volume
Command to check for running containers:
docker ps

Command to list volumes on your host machine:
docker volume ls

Command to check for container logs:
docker-compose logs -f # All
docker-compose logs -f wordpress # Specific

Command to execute a shell inside a container:
docker exec -it <container_name> sh
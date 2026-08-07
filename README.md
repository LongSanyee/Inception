*This project has been created as part of the 42 curriculum by rammisse.*

## Description
- The Inception project is an introduction to sys administration and DevOps. the objective is to build a secure fully functioning website running inside isolated Docker containers

- Instead of installing the programs directly on a server you divide the services into 3 seperate boxes (containers) that talk to each other over a private network

- The 3 services
Nginx: your webserver the only part of the project exposed to the outside internet it receives traffic and safely passes it back into the website
Wordpress + PHP-FPM: the website engine it translates the code generate the webpage and installs itself via its CLI tool
Mariadb: Your database it stores all the websites users,posts,and settings for security its completely cut off from the internet and will only accept data from Wordpress

## Instructions

1. Prerequisites
Make sure you have Docker, Docker Compose, and Make installed on your machine.

2. Setup
Domain: Open your /etc/hosts file (as root) and add this line so your browser can route the traffic correctly:
127.0.0.1    rammisse.42.fr

Passwords: Create a .env file in the root folder (next to the Makefile). Add your database and WordPress credentials like this:
{
    DOMAIN_NAME=rammisse.42.fr
    MYSQL_DB=wordpress
    MYSQL_USER=wp_user
    MYSQL_PASSWORD=your_db_password
    MYSQL_ROOT_PASSWORD=your_root_password
    WP_ADMIN_USER=admin
    WP_ADMIN_PWD=your_admin_password
    WP_ADMIN_MAIL=admin@rammisse.42.fr
    WP_USER=author
    WP_USER_PWD=your_author_password
    WP_USER_MAIL=author@rammisse.42.fr
}

3. Build and Run
Run this single command to build the containers and start the project in the background:
make
Wait a moment for the setup scripts to finish, then go to https://rammisse.42.fr in your browser.
(Note: You will need to click "Advanced" and accept the security warning because the TLS certificate is self-signed).

4. Stopping and Cleaning
To stop the containers safely:
make clean

To completely delete everything, including all your saved database and WordPress files:
make fclean

To wipe everything out and start over completely fresh:
make re

## Resources
- https://dev.to/piyushjajoo/how-docker-actually-works-a-deep-dive-into-the-internals-501d#9-networking-internals
- https://www.youtube.com/watch?v=eGz9DS-aIeY
- https://www.youtube.com/watch?v=bKFMS5C4CG0&t=426s
- AI was used to clarify how exactly does the docker pipleline reach the kernel

## Project Description
Main Design Choices:
* **Microservices Architecture:** The project strictly follows the rule of one service per container. Nginx, WordPress, and MariaDB are isolated from each other to improve security and maintainability.
* **Foreground Execution:** All main services (like Nginx and PHP-FPM) are configured to run in the foreground. This is necessary because Docker containers will automatically exit if their primary PID 1 process is sent to the background.
* **Full Automation:** Custom `entrypoint.sh` scripts are used to automatically generate SSL certificates and install WordPress via WP-CLI on startup, completely removing the need for manual web browser configuration.
* **Lightweight Base:** All containers are built from scratch using a minimal base OS (like Alpine or Debian) to keep the images small and secure, strictly avoiding pre-made images like `nginx:latest`.

Docker Usage:
Docker provides isolation and reproducibility. By putting each service in its own container, you guarantee that the website will run exactly the same way on any computer, without messing up the host machine's settings or conflicting with other software.

Sources Included:
Because the project strictly forbids the use of pre-configured Docker Hub images (such as `nginx:latest` or `mariadb:latest`), all containers are built from scratch. The sources included in this repository consist of:
* **Dockerfiles:** Custom instructions to build the Nginx, WordPress, and MariaDB images using a bare Alpine or Debian Linux base.
* **Configuration Files:** Custom server configurations including `nginx.conf` (for web routing and TLS), `www.conf` (for PHP-FPM), and `50-server.cnf` (for MariaDB).
* **Entrypoint Scripts:** Custom Bash scripts (`entrypoint.sh`) that run automatically when the containers boot to handle tasks like generating SSL certificates, creating database users, and installing WordPress via WP-CLI.
* **Orchestration:** A `docker-compose.yml` file to link the containers via a private network, and a `Makefile` to automate the build and teardown process.

Technical Comparisons:

Virtual Machines vs Docker:

Virtual Machines (VMs): VMs virtualize the hardware. Every VM runs a full, heavy guest Operating System with its own kernel on top of a hypervisor. This provides strong isolation but consumes massive amounts of RAM and CPU, and takes longer to boot.

Docker: Docker virtualizes the Operating System layer. Containers share the host machine's kernel and only package the necessary binaries and application libraries. This makes containers extremely lightweight, highly efficient, and capable of booting in milliseconds.

Secrets vs Environment Variables:

Environment Variables: These are variables injected into the container's environment space. While easy to use, they can be insecure because any process inside the container can read them, and they can accidentally be leaked in error logs or by running commands like env.

Docker Secrets: This is a more secure mechanism (built into Docker Swarm). Instead of injecting data into the environment, secrets are securely mounted as temporary, read-only files directly into the container's RAM (tmpfs). They never touch the physical hard drive, significantly reducing the risk of data leaks.

Docker Network vs Host Network:

Host Network: If a container uses the host network driver, it completely bypasses Docker's network isolation. It shares the host machine's IP address and networking stack directly, meaning port conflicts can easily occur with other host applications.

Docker Network (Bridge): The default Docker network creates a secure, isolated virtual subnet. Containers on this network can communicate with each other securely using internal DNS (e.g., WordPress talking to MariaDB), but they are completely invisible to the host machine and the outside internet unless a port is explicitly opened (like port 443 for Nginx).

Docker Volumes vs Bind Mounts:

Bind Mounts: A bind mount maps a specific, exact file path from your host machine (e.g., /home/user/desktop/code) into the container. It is highly dependent on the host's directory structure and can cause permission issues depending on the host OS.

Docker Volumes: Volumes are managed entirely by Docker itself and stored in a dedicated, hidden directory on the host (/var/lib/docker/volumes). Volumes are the preferred way to persist database and application data because they are completely decoupled from the host's specific file system, making them safer, easier to back up, and easier to migrate between different servers.

# User Documentation: Inception

## 1. Services Provided
This project deploys a secure, containerized web infrastructure stack consisting of three main services:
*   **Nginx:** A web server acting as the secure entry point (HTTPS/TLS) for all web traffic.
*   **WordPress:** The Content Management System (CMS) running via PHP-FPM to serve the website.
*   **MariaDB:** The relational database that safely stores all website text, user data, and configurations.

## 2. Starting and Stopping the Project
The project is managed via a Makefile. Navigate to the root of the project directory in your terminal:
*   **To start the project:** Run make or make up.
*   **To stop the project:** Run make down
*   **To completely clean the project (including data):** Run make fclean.

## 3. Accessing the Website
Once the containers are running, open a web browser:
*   Main Website: https://rammisse.42.fr
*   Administration Panel: https://rammisse.42.fr/wp-admin

*(Note: Your browser may show a security warning because the TLS certificate is self-signed. You must accept the risk to proceed.)*

## 4. Locating and Managing Credentials
All sensitive credentials (database passwords, WordPress admin details, etc.) are managed through environment variables. 
*   They are located in the .env file at the root of the project directory.
*   To change a credential, stop the project, edit the .env file, and restart the project.

## 5. Checking Service Status
To verify that all services are running correctly, open a terminal and run:
docker ps
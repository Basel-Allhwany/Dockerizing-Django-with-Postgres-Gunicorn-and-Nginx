# Dockerizing-Django-with-Postgres-Gunicorn-and-Nginx
# Table of Contents

## [Prerequisites](#prerequisites)        |  [How to Build](#how-to-build)      |    [Configuration](#configuration)      |    [Using Docker-compose](#using-docker-compose)

## Prerequisites

Before starting, ensure you have the following prerequisites installed:

- Docker
- Docker Compose

## How to Build

1. Clone the repository to your local machine:

    ```bash
    git clone https://github.com/Basel-Allhwany/Dockerizing-a-Django-Web-With-mySql.git
    cd Dockerizing-a-Django-Web-With-mySql
    ```
2. Create a network for container communication:

    ```bash
    docker network create --subnet 10.0.0.0/24 Docker-network
    ```
 3. Run the Postgres container:
    
    ```bash
    docker run -d --network Docker-network --ip 10.0.0.21 --name django-db -e POSTGRES_PASSWORD=password -e POSTGRES_DB=django-db -p 5432:5432 -d postgres
    ```
    - docker run: This initiates a new container.
    - --name django-db: Assigns the name “django-db” to the container.
    - -e POSTGRES_PASSWORD=password: Specifies the password for the PostgreSQL user.
    - -e POSTGRES_DB=django-db: Defines the name of the PostgreSQL database as “django-db.”
    - -p 5432:5432: Maps port 5432 on the host to port 5432 in the container (the default PostgreSQL port).
    - -d postgres: Specifies the Docker image to use (in this case, the official PostgreSQL image).

4. Build and run the Django container:

    ```bash
    cd app
    docker build -t my-django .
    docker run -d --network Docker-network --ip 10.0.0.10 --hostname django my-django
    ```

5. Build and run the Nginx container:

    ```bash
    cd ../nginx
    docker build -t my-nginx .
    docker run -d --network Docker-network --ip 10.0.0.11 -p 80:80 --hostname nginx my-nginx
    ```

6. Migrate tables to the new database:

    ```bash
    docker exec -it <django_container_id> bash
    cd ~/app
    python3 manage.py migrate
    ```
   to Check tables in the Postgres container :

     ```bash
      docker exec -it <mysql container id> bash

       $ psql -U postgres --password
       > \dt;
    ```
     ![Screenshot from 2024-04-02 18-07-15](https://github.com/Basel-Allhwany/Dockerizing-Django-with-Postgres-Gunicorn-and-Nginx/assets/165336853/54a7fd7a-dadc-481f-bf16-57142cb2456f)

7.Finally go to http://10.0.0.11 to Check The Connectivity  
![تصميم بدون عنوان(1)](https://github.com/Basel-Allhwany/Dockerizing-Django-with-Postgres-Gunicorn-and-Nginx/assets/165336853/c4891997-ded6-4fe2-b386-8cddf9dfd721)


    
## Configuration
- configure django settings by editting ./django-g/app/hello_django/settings.py file
![Screenshot from 2024-04-02 17-47-57](https://github.com/Basel-Allhwany/Dockerizing-Django-with-Postgres-Gunicorn-and-Nginx/assets/165336853/556b3586-c199-4279-9e1b-71c018e90611)

- The proxy pass and the server name can be configured by editting ./etc/nginx/conf.d/default.conf file
![Screenshot from 2024-04-02 17-49-04](https://github.com/Basel-Allhwany/Dockerizing-Django-with-Postgres-Gunicorn-and-Nginx/assets/165336853/21cc88be-c926-4f0e-b790-e98c0ee79076)

## Using Docker-compose
1. Clone the repository to your local machine:

    ```bash
    git clone https://github.com/Basel-Allhwany/Dockerizing-a-Django-Web-With-mySql.git
    cd Dockerizing-a-Django-Web-With-mySql
    ```

2.  Run docker-compose 
  ```bash
   docker-compose up -d --build
  ```
3. Migrate Tables To The New Database:
  ```bash
  docker-compose exec web bash
  # python manage.py migrate
  ```
4. Finally You Can Check The Connectivity Now


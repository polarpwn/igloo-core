---
title: Setting-Up Damn Vulnerable Web Application (DVWA) in Docker 
linkTitle: Setting-Up DVWA
authors:
  - name: monsieurDuke
    link: https://github.com/monsieurDuke
cascade:
  type: docs
weight: 99998
---
*Discovering and learning web application vulnerabilities just got easier with Damn Vulnerable Web Application (DVWA) platform. In this blog, we explore a straightforward and efficient process to deploy DVWA on your Linux machine using the power of Podman, which brings minimal resources yet powerful functionalities for your daily pentest learning journey*
<!--more-->

## What Is DVWA?
Damn Vulnerable Web Application (DVWA) is a PHP/MySQL web application that intends to become a security hands-on lab that is easily accessible and deployed within our local environment. That way, we can learn, practice, and understand the process of securing web applications in multiple degrees from kinds of cases; from Brute Force, Command Injection, types of File Inclusions, types of XSS's, to Authorisation Bypass, which is the newly added. 

By default, DVWA service is already available within the Kali package repository, ready to be installed via ```apt```. Note that the dependencies compared to the Docker image from [Vulnerables](https://hub.docker.com/r/vulnerables/web-dvwa) are different as the image solely uses PHP 7.0 and Apache, while [Kali](https://www.kali.org/tools/dvwa/) already introduced the usage of NGINX with PHP-FPM 8.3 module, which makes the application easier to manage as it makes PHP its daemon and configuration; separated from the service.

## First Time Setting-Up
On this tutorial, we are going to use ```docker compose``` to build DVWA's essential services, they are the web service via Apache and database service via MySQL. The configuration and the image itself are prebuilt from [digininja/DVWA](https://github.com/digininja/DVWA/), which is the official DVWA repository. By doing this approach, you can get the latest update that you didnt get from Vulnerables, and you don't have to keep relying on your dedicated Kali box for instance. Now let's get into it!

### Installing Docker
If you are not familiar, Docker is a containerization platform that allows you to package an application and its dependencies together into a single unit called a container. Before we begin, make sure your system meets the requirements for running Docker from the operating systems and hardware virtualization support, which you can check it out from their official documentation for all the major platform, such as Mac, Windows, and other Linux derivatives.

Since we're using Debian for this tutorial, we can start by installing the main dependencies as well as adding the Docker repository into our package sources, so that we can easily install it through ```apt```. Though if have already installed Docker and the compose plugin, you may wanted to jump onto the [next section](#building-through-docker-compose).

```bash
# add Docker's official GPG key
$ sudo apt-get update
$ sudo apt-get install ca-certificates curl gnupg
$ sudo install -m 0755 -d /etc/apt/keyrings
$ curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
$ sudo chmod a+r /etc/apt/keyrings/docker.gpg

# add the repository to APT sources
# you might wanted to change to $UBUNTU_CODENAME instead for Ubuntu derivative
$ echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```
```bash
$ sudo apt-get update
$ sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
$ sudo usermod -aG docker icat # replace `icat` with your username
```

### Building through Docker Compose
To streamline the deployment of DVWA, we'll leverage Docker Compose—a tool for defining and running multi-container Docker applications. Our starting point is the [digininja/DVWA](https://github.com/digininja/DVWA/) GitHub repository, a comprehensive resource maintained by the security expert Digininja. This repository provides a Dockerized version of DVWA, making it convenient for us to set up our vulnerable web application in a controlled environment. Here is the base configuration of ```compose.yml``` that we will be using, which you can modified yourself to suit the needs.

```bash {linenos=table,linenostart=1,filename="compose.yml"}
volumes:
  dvwa:

networks:
  dvwa:

services:
  dvwa:
    build: .
    image: ghcr.io/digininja/dvwa:latest
    pull_policy: always
    environment:
      - DB_SERVER=db
    depends_on:
      - db
    networks:
      - dvwa
    ports:
      - 4280:80
    restart: unless-stopped

  db:
    image: docker.io/library/mariadb:10
    environment:
      - MYSQL_ROOT_PASSWORD=dvwa
      - MYSQL_DATABASE=dvwa
      - MYSQL_USER=dvwa
      - MYSQL_PASSWORD=p@ssw0rd
    volumes:
      - dvwa:/var/lib/mysql
    networks:
      - dvwa
    restart: unless-stopped
```
Here, we are going to clone the official repository. onto then, we can build the DVWA services by running the container with predifined configurations of the compose file, while detaching the service to be a background job

```bash
$ git clone https://github.com/digininja/DVWA.git
$ docker compose up -d
```

```bash
$ docker ps
CONTAINER ID   IMAGE                           COMMAND                  CREATED        STATUS       PORTS                                   NAMES
317dc9867e91   ghcr.io/digininja/dvwa:latest   "docker-php-entrypoi…"   31 hours ago   Up 7 hours   0.0.0.0:4280->80/tcp, :::4280->80/tcp   dvwa-dvwa-1 
4291ea09e525   mariadb:10                      "docker-entrypoint.s…"   31 hours ago   Up 7 hours   3306/tcp                                dvwa-db-1
```

### Configuring Dependencies
#### File Inclusion
```bash
$ docker exec -it dvwa-dvwa-1 /bin/bash
$ docker exec dvwa-dvwa-1 sed -i 's/allow_url_include = Off/allow_url_include = On/g' /usr/local/etc/php/php.ini-development 
$ docker exec dvwa-dvwa-1 sed -i 's/allow_url_include = Off/allow_url_include = On/g' /usr/local/etc/php/php.ini-production 
```

#### Insecure CAPTCHA
- register google recaptcha key config
  > label: dvwa-dvwa-1 
  > recaptcha-type: Challange v2 -> Invinsible reCAPTCHA badge
  > domain: localhost
- site key: 6LcHpzspAAAAABVWU_mRIPjnC3jaG77BXRxDMDfq
- secret key: 6LcHpzspAAAAAO8EEzI9yDeD_DfBkq-YiQCzXhc3

```bash
$ grep -n recaptcha /var/www/html/config/config.inc.php
$ docker exec dvwa-dvwa-1 sed -i '27s/\x27\x27/\x276LcHpzspAAAAABVWU_mRIPjnC3jaG77BXRxDMDfq\x27/' /var/www/html/config/config.inc.php
$ docker exec dvwa-dvwa-1 sed -i '28s/\x27\x27/\x276LcHpzspAAAAAO8EEzI9yDeD_DfBkq-YiQCzXhc3\x27/' /var/www/html/config/config.inc.php 
```

## Finalizing Setup

```bash
$ docker exec dvwa-dvwa-1 /etc/init.d/apache2 reload
```
wdawdawd
![](/images/blog/dvwa.webp "DVWA Setup Check Page")

awdaawd

## Resources
- https://github.com/digininja/DVWA 

## References
- https://docs.docker.com/engine/install/ubuntu/
- https://docs.docker.com/compose/install/linux/

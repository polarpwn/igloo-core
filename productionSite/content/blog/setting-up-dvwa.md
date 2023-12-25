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
Damn Vulnerable Web Application (DVWA) is a PHP/MySQL web application that intends to become a security hands-on lab that is easily accessible and deployed within our local environment. That way, we can learn, practice, and understand the process of securing web applications in multiple degrees from kinds of cases. By default, DVWA service is already available within the Kali package repository, ready to be installed via ```apt```. Note that the dependencies compared to the [Docker image](https://hub.docker.com/r/vulnerables/web-dvwa) are different as the image solely uses ```PHP 7.0``` and ```apache2```, while [Kali](https://www.kali.org/tools/dvwa/) already introduced the usage of ```nginx``` with ```PHP-FPM 8.2``` module, which makes the application easier to manage as it makes PHP its daemon and configuration; separated from the ```nginx``` service.

## First Time Setting-Up
### Installing Docker 
- install docker + docker compose plugin

### Building through Docker Compose
- git clone https://github.com/digininja/DVWA.git
- sudo docker compose up -d
- sudo docker ps

### Configuring Dependencies
#### File Inclusion
- sudo docker exec -it dvwa-dvwa-1 /bin/bash
- sudo docker exec dvwa-dvwa-1 sed -i 's/allow_url_include = Off/allow_url_include = On/g' /usr/local/etc/php/php.ini-development 
- sudo docker exec dvwa-dvwa-1 sed -i 's/allow_url_include = Off/allow_url_include = On/g' /usr/local/etc/php/php.ini-production 

#### Insecure CAPTCHA
- register google recaptcha key config
  > label: dvwa-dvwa-1 
  > recaptcha-type: Challange v2 -> Invinsible reCAPTCHA badge
  > domain: localhost
- site key: 6LcHpzspAAAAABVWU_mRIPjnC3jaG77BXRxDMDfq
- secret key: 6LcHpzspAAAAAO8EEzI9yDeD_DfBkq-YiQCzXhc3

- grep -n recaptcha /var/www/html/config/config.inc.php
- sudo docker exec dvwa-dvwa-1 sed -i '27s/\x27\x27/\x276LcHpzspAAAAABVWU_mRIPjnC3jaG77BXRxDMDfq\x27/' /var/www/html/config/config.inc.php
- sudo docker exec dvwa-dvwa-1 sed -i '28s/\x27\x27/\x276LcHpzspAAAAAO8EEzI9yDeD_DfBkq-YiQCzXhc3\x27/' /var/www/html/config/config.inc.php 

## Finalizing Setup
- sudo docker exec dvwa-dvwa-1 /etc/init.d/apache2 reload

## Resources
- https://github.com/digininja/DVWA 

## References
- https://docs.docker.com/engine/install/ubuntu/
- https://docs.docker.com/compose/install/linux/

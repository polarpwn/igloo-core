---
title: Weaponizing Ubuntu for Red Teaming Purposes in Docker
linkTitle: Weaponized Ubuntu 
authors:
  - name: monsieurDuke
    link: https://github.com/monsieurDuke
cascade:
  type: docs
weight: 99997
---
<!--more-->

## Installing Distrobox
- install docker apt or via deb package: https://docs.docker.com/engine/install/ubuntu/
- sudo apt-get install distrobox

## Installing Metasploit
- cd /opt/
- sudo wget http://downloads.metasploit.com/data/releases/metasploit-latest-linux-x64-installer.run
- sudo chmod +x metasploit-latest-linux-x64-installer.run
- sudo ./metasploit-latest-linux-x64-installer.run 
  > Terms of Service License ( y )
  > Installation Folder ( /opt/metasploit )
  > Install as a Service ( y )
  > Disable Anti-Virus and Firewall ( y )
  > Metasploit Service ( SSL Port 3790, SSL Server Name localhost, SSL Validity 3650, Trust Cert Y )
- sudo service metasploit status

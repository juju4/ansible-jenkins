#!/bin/sh

## add here all roles dependencies
## main roles will be uploaded by packer
cd /etc/ansible/roles
git clone https://github.com/geerlingguy/ansible-role-java.git geerlingguy.java
git clone https://github.com/geerlingguy/ansible-role-jenkins.git geerlingguy.jenkins
git clone https://github.com/geerlingguy/ansible-role-nginx.git geerlingguy.nginx


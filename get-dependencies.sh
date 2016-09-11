#!/bin/sh
## one script to be used by travis, jenkins, packer...

umask 022

rolesdir=$(dirname $0)/..

[ ! -d $rolesdir/geerlingguy.java ] && git clone https://github.com/geerlingguy/ansible-role-java.git $rolesdir/geerlingguy.java
[ ! -d $rolesdir/geerlingguy.nginx ] && git clone https://github.com/geerlingguy/ansible-role-nginx.git $rolesdir/geerlingguy.nginx
[ ! -d $rolesdir/geerlingguy.jenkins ] && git clone https://github.com/geerlingguy/ansible-role-jenkins.git $rolesdir/geerlingguy.jenkins
[ ! -d $rolesdir/tersmitten.nodejs ] && git clone https://github.com/Oefenweb/ansible-nodejs.git $rolesdir/tersmitten.nodejs


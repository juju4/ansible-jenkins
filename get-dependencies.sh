#!/bin/sh
## one script to be used by travis, jenkins, packer...

umask 022

if [ $# != 0 ]; then
rolesdir=$1
else
rolesdir=$(dirname $0)/..
fi

[ ! -d $rolesdir/juju4.redhat-epel ] && git clone https://github.com/juju4/ansible-redhat-epel $rolesdir/juju4.redhat-epel
#[ ! -d $rolesdir/geerlingguy.java ] && git clone https://github.com/geerlingguy/ansible-role-java.git $rolesdir/geerlingguy.java
# RedHat-7 customization
[ ! -d $rolesdir/geerlingguy.java ] && git clone https://github.com/juju4/ansible-role-java.git $rolesdir/geerlingguy.java
#[ ! -d $rolesdir/kbrebanov.java ] && git clone https://github.com/kbrebanov/ansible-java $rolesdir/kbrebanov.java
[ ! -d $rolesdir/kbrebanov.java ] && git clone https://github.com/juju4/ansible-java $rolesdir/kbrebanov.java
[ ! -d $rolesdir/geerlingguy.nginx ] && git clone https://github.com/geerlingguy/ansible-role-nginx.git $rolesdir/geerlingguy.nginx
#[ ! -d $rolesdir/geerlingguy.jenkins ] && git clone https://github.com/geerlingguy/ansible-role-jenkins.git $rolesdir/geerlingguy.jenkins
[ ! -d $rolesdir/geerlingguy.jenkins ] && git clone https://github.com/juju4/ansible-role-jenkins.git $rolesdir/geerlingguy.jenkins
[ ! -d $rolesdir/tersmitten.nodejs ] && git clone https://github.com/Oefenweb/ansible-nodejs.git $rolesdir/tersmitten.nodejs
[ ! -d $rolesdir/juju4.w3af ] && git clone https://github.com/juju4/ansible-w3af $rolesdir/juju4.w3af
[ ! -d $rolesdir/juju4.harden-nginx ] && git clone https://github.com/juju4/ansible-harden-nginx $rolesdir/juju4.harden-nginx
## to configure ssh auth to jenkins
[ ! -d $rolesdir/cmprescott.xml ] && git clone https://github.com/cmprescott/ansible-xml.git $rolesdir/cmprescott.xml
## galaxy naming: kitchen fails to transfer symlink folder
#[ ! -e $rolesdir/juju4.jenkins ] && ln -s ansible-jenkins $rolesdir/juju4.jenkins
[ ! -e $rolesdir/juju4.jenkins ] && cp -R $rolesdir/ansible-jenkins $rolesdir/juju4.jenkins

## don't stop build on this script return code
true


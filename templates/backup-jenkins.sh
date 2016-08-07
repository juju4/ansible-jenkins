#!/bin/sh
## backup script for jenkins
## https://wiki.jenkins-ci.org/display/JENKINS/Administering+Jenkins
## http://www.holisticqa.com/2013/11/backing-up-your-jenkins-configuration/

export PATH=/usr/sbin:/usr/bin:/sbin:/bin
umask 022

dest={{ backupdir }}

dirs="/var/lib/jenkins \
    /var/log/jenkins \
    "

## exclude workspaces and plugins ?
tar czf --exclude 'plugins/*/*' \
    --exclude cache \
    --exclude 'config-history/*' \
    $dest/backup-jenkins.tar.gz $dirs
tar tzf $dest/backup-icinga2.tar.gz > /dev/null



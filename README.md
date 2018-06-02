[![Build Status - Master](https://travis-ci.org/juju4/ansible-jenkins.svg?branch=master)](https://travis-ci.org/juju4/ansible-jenkins)
[![Build Status - Devel](https://travis-ci.org/juju4/ansible-jenkins.svg?branch=devel)](https://travis-ci.org/juju4/ansible-jenkins/branches)
# Jenkins ansible role

Ansible role to setup jenkins with java.
Test environment tools are addressed in jenkinsenv role.
You can use jenkinsslave role to setup extra nodes.

## Requirements & Dependencies

### Ansible
It was tested on the following versions:
 * 2.0
 * 2.2
 * 2.5

### Operating systems

Tested with vagrant on Ubuntu 14.04, Kitchen test with trusty and centos7

## Example Playbook

Just include this role in your list.
For example

```
- host: all
  roles:
    - juju4.jenkins
```

## Variables

```
## possible gitlab is taking 8080
jenkins_http_port: 8888

jenkins_plugins:
    - antisamy-markup-formatter
    - build-timeout 
    - credentials-binding

jenkins_java_options: "-Djenkins.install.runSetupWizard=false -Dmail.smtp.starttls.enable=true"

jenkins_git_email: myuser@users.noreply.github.com
jenkins_git_user: myuser

#jenkins_smtphost: 127.0.0.1
#jenkins_smtp_defaultdomain: example.com
```

## Continuous integration

This role has a travis basic test (for github), more advanced with kitchen and also a Vagrantfile (test/vagrant).
Default kitchen config (.kitchen.yml) is lxd-based, while (.kitchen.vagrant.yml) is vagrant/virtualbox based.

Once you ensured all necessary roles are present, You can test with:
```
$ gem install kitchen-ansible kitchen-lxd_cli kitchen-sync kitchen-vagrant
$ cd /path/to/roles/juju4.jenkins
$ kitchen verify
$ kitchen login
$ KITCHEN_YAML=".kitchen.vagrant.yml" kitchen verify
```
or
```
$ cd /path/to/roles/juju4.jenkins/test/vagrant
$ vagrant up
$ vagrant ssh
```

## FAQ

* (WIP) To connect Jenkins to GitHub
recover jenkins user ssh key (/home/jenkins/.ssh/) and add it to GitHub
validate with ```ssh -T git@github.com``` (https://help.github.com/articles/testing-your-ssh-connection/)
For one project, add your server url http://jenkins.example.com/github-webhook to Settings: Integration & Services: Jenkins (GitHub plugin)
https://blog.bartbania.com/docker/jenkins-github-docker/
Add it in Jenkins: Configure: GitHub: GitHub server with credentials as secret text (copy GitHub Token here)
Check if working, after a new push or using GitHub 'Test service' option, you should match in nginx log 'POST /github-webhook'

## Troubleshooting & Known issues

* Reset user password
Edit /var/lib/jenkins/users/<user>/config.xml and remove content of passwordHash.
Alternative is to disable security in jenkins but it open all access to everyone: https://wiki.jenkins-ci.org/display/JENKINS/Disable+security

* Check /var/log/jenkins/jenkins.log for
java.lang.OutOfMemoryError: Java heap space
https://wiki.jenkins-ci.org/display/JENKINS/Builds+failing+with+OutOfMemoryErrors

* If you use node install through ssh and you have build using ssh (eg svn+ssh), you are advise to use separate key to separate risks.

* Chunk error
```SEVERE: I/O error in channel Chunked connection to http://localhost:8080/cli
java.io.StreamCorruptedException: invalid stream header: 0A0A0A0A
```
=
https://issues.jenkins-ci.org/browse/JENKINS-23232
possible fix TCP port for JNLP agents (fixed value, not random, not disabled)

* No X-Jenkins-CLI2-Port
```
java.io.IOException: No X-Jenkins-CLI2-Port among [X-Jenkins, null, Date, X-Hudson-Theme, X-Hudson, Content-Length, Expires, X-Jenkins-Session, Set-Cookie, Content-Type, Server, X-Content-Type-Options, Cache-Control]
```
https://github.com/geerlingguy/ansible-role-jenkins/issues/47
check also which url path is correct / or /jenkins

* Jenkins Github hook
jenkins.log:
```
org.eclipse.jetty.util.log.JavaUtilLog warn
WARNING: badMessage: java.lang.IllegalStateException: too much data after closed for HttpChannelOverHttp@1d0a07a6{r=1,c=false,a=IDLE,uri=}
```
https://stackoverflow.com/questions/29527803/eliminating-or-understanding-jetty-9s-illegalstateexception-too-much-data-aft

* ```It appears that your reverse proxy set up is broken.```
https://wiki.jenkins-ci.org/display/JENKINS/Jenkins+says+my+reverse+proxy+setup+is+broken



## License

BSD 2-clause


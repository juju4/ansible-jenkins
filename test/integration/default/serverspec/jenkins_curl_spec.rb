require 'serverspec'

# Required by serverspec
set :backend, :exec

#jenkins_url = 'http://localhost:9091/'
jenkins_url = 'https://localhost:9091/login'
curl_arg = '-vkL'

describe command("curl #{curl_arg} #{jenkins_url}"), :if => os[:family] == 'ubuntu' do
#  its('stdout') { should match /<meta http-equiv='refresh' content='1;url=\/login?from=%2F'\/>/ }
  its('stdout') { should match /<title>Sign in \[Jenkins\]<\/title>/ }
#  its('stdout') { should match /Log in<\/a> to create new jobs/ }
  its('stderr') { should match /HTTP\/1.1 200 OK/ }
#  its('stderr') { should match /X-Hudson-Theme/ }
  its('stderr') { should match /subject: C=US,ST=CA,L=San Francisco,O=Ansible,CN=default-/ }
end

describe command("curl #{curl_arg} #{jenkins_url}login"), :if => os[:family] == 'redhat' do
  its('stdout') { should match /<meta http-equiv='refresh' content='1;url=\/login?from=%2F'\/>/ }
#  its('stdout') { should match /<title>Dashboard \[Jenkins\]<\/title>/ }
#  its('stdout') { should match /Log in<\/a> to create new jobs/ }
  its('stderr') { should match /HTTP\/1.1 200 OK/ }
  its('stderr') { should match /X-Hudson-Theme/ }
  its('stderr') { should match /subject: C=US,ST=CA,L=San Francisco,O=Ansible,CN=default-/ }
end

## plugins test
describe command("curl #{curl_arg} #{jenkins_url}/git/notifyCommit?url=") do
  its('stdout') { should match "java.lang.Exception: Illegal URL:" }
  its('stdout') { should_not match "404 Not Found" }
end
#describe command("curl #{curl_arg} #{jenkins_url}/github-webhook/") do
#  its('stdout') { should match "java.lang.Exception: Method POST required" }
#  its('stdout') { should_not match "404 Not Found" }
#  its('stdout') { should match "Authentication required" }
#end

## https://wiki.jenkins-ci.org/display/JENKINS/Jenkins+says+my+reverse+proxy+setup+is+broken (how to get api_token in cli?)
#describe command('curl -iL -u admin:###api_token### -e http://localhost:9091/manage http://localhost:9091/administrativeMonitor/hudson.diagnosis.ReverseProxySetupMonitor/test') do
#  its('stdout') { should match // }
#end

require 'serverspec'

# Required by serverspec
set :backend, :exec


describe command('curl -v http://localhost:9091/') do
#  its('stdout') { should match /<meta http-equiv='refresh' content='1;url=\/login?from=%2F'\/>/ }
  its('stdout') { should match /You are authenticated as: anonymous/ }
  its('stderr') { should match "HTTP/1.1 403 Forbidden" }
end

## plugins test
describe command('curl -vkL http://localhost:9091/git/notifyCommit?url=') do
  its('stdout') { should match "java.lang.Exception: Illegal URL:" }
  its('stdout') { should_not match "404 Not Found" }
end
describe command('curl -vkL http://localhost:9091/github-webhook/') do
  its('stdout') { should match "java.lang.Exception: Method POST required" }
  its('stdout') { should_not match "404 Not Found" }
end

## https://wiki.jenkins-ci.org/display/JENKINS/Jenkins+says+my+reverse+proxy+setup+is+broken (how to get api_token in cli?)
#describe command('curl -iL -u admin:###api_token### -e http://localhost:9091/manage http://localhost:9091/administrativeMonitor/hudson.diagnosis.ReverseProxySetupMonitor/test') do
#  its('stdout') { should match // }
#end

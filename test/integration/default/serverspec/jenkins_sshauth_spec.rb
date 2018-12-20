require 'serverspec'

# Required by serverspec
set :backend, :exec

describe command('ls /var/lib/jenkins/users/admin*/config.xml') do
  its(:stdout) { should match /config.xml/ }
  its(:stderr) { should be_empty }
  its(:exit_status) { should eq 0 }
end

adminxml_filepath = command('ls /var/lib/jenkins/users/admin*/config.xml').stdout.strip!
describe file(adminxml_filepath) do
  it { should be_readable }
  its(:content) { should match /org.jenkinsci.main.modules.cli.auth.ssh.UserPropertyImpl/ }
  its(:content) { should match /jenkins-key-for-/ }
end

require 'serverspec'

# Required by serverspec
set :backend, :exec

describe file('/var/lib/jenkins/users/admin/config.xml') do
  it { should be_readable }
  its(:content) { should match /org.jenkinsci.main.modules.cli.auth.ssh.UserPropertyImpl/ }
  its(:content) { should match /jenkins-key-for-ffate/ }
end


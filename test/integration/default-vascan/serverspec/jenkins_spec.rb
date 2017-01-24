require 'serverspec'

# Required by serverspec
set :backend, :exec

describe service('jenkins') do  
  it { should be_enabled   }
  it { should be_running   }
end  

describe file('/var/lib/jenkins/config.xml') do
  it { should be_readable }
end

describe process("java") do
  its(:user) { should eq "jenkins" }
  its(:args) { should match /-jar \/usr\/share\/jenkins\/jenkins.war/ }
end

describe port(8888) do
  it { should be_listening }
end

describe command('java -jar /opt/jenkins-cli.jar -s http://127.0.0.1:8888/ version --username admin --password admin'), :if => os[:family] == 'ubuntu' && os[:release] == '16.04' do
  its(:exit_status) { should eq 0 }
end
describe command('java -jar /opt/jenkins-cli.jar -s http://127.0.0.1:8888/ list-plugins --username admin --password admin'), :if => os[:family] == 'ubuntu' && os[:release] == '16.04' do
  its(:stdout) { should match /git/ }
  its(:stdout) { should match /checkstyle/ }
  its(:exit_status) { should eq 0 }
end

describe command('java -jar /opt/jenkins-cli.jar -s http://127.0.0.1:8888/jenkins version --username admin --password admin'), :if => os[:family] == 'ubuntu' && os[:release] == '14.04' do
  its(:exit_status) { should eq 0 }
end
describe command('java -jar /opt/jenkins-cli.jar -s http://127.0.0.1:8888/jenkins list-plugins --username admin --password admin'), :if => os[:family] == 'ubuntu' && os[:release] == '14.04' do
  its(:stdout) { should match /git/ }
  its(:stdout) { should match /checkstyle/ }
  its(:exit_status) { should eq 0 }
end

#java -jar /opt/jenkins-cli.jar -s http://127.0.0.1:8888 login --username admin --password admin
#java -jar /opt/jenkins-cli.jar -s http://127.0.0.1:8888 get-job test-uptime | tee /vagrant/job-test-uptime.xml
#java -jar /opt/jenkins-cli.jar -s http://127.0.0.1:8888 create-job test-uptime < /vagrant/job-test-uptime.xml
#java -jar /opt/jenkins-cli.jar -s http://127.0.0.1:8888 build test-uptime


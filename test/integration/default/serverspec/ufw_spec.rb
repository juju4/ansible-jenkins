require 'serverspec'

# Required by serverspec
set :backend, :exec


describe command('host www.google.com') do
  its('stdout') { should match /www.google.com has address / }
end
describe command('curl -v https://www.google.com/'), :if => (os[:family] == 'ubuntu' && os[:release] == '16.04') || (os[:family] == 'redhat' && os[:release] == '7') do
  its('stdout') { should match /<title>Google<\/title>/ }
  its('stderr') { should match /HTTP\/1.1 200 OK/ }
end
describe command('curl -v https://www.google.com/'), :if => (os[:family] == 'ubuntu' && (os[:release] == '18.04' || os[:release] == '20.04')) || (os[:family] == 'redhat' && os[:release] == '8') do
  its('stdout') { should match /<title>Google<\/title>/ }
  its('stderr') { should match /HTTP\/2 200/ }
end
describe command('curl -v https://www.github.com/') do
  its('stderr') { should match /HTTP\/1.1 301 Moved Permanently/ }
end
describe command('ufw status verbose') do
  its('stdout') { should match /Status: active/ }
  its('stdout') { should match /Logging: on/ }
  its('stdout') { should match /Default: deny \(incoming\), deny \(outgoing\), (deny|disabled) \(routed\)/ }
end


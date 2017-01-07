require 'serverspec'

# Required by serverspec
set :backend, :exec


describe command('host www.google.com') do
  its('stdout') { should match /www.google.com has address / }
end
describe command('curl -v https://www.google.com/') do
  its('stdout') { should match /The document has moved/ }
  its('stderr') { should match /HTTP\/1.1 302 Found/ }
end
describe command('curl -v https://www.github.com/') do
  its('stderr') { should match /HTTP\/1.1 301 Moved Permanently/ }
end
describe command('ufw status verbose') do
  its('stdout') { should match /Status: active/ }
  its('stdout') { should match /Logging: on/ }
  its('stdout') { should match /Default: deny \(incoming\), deny \(outgoing\), deny \(routed\)/ }
end


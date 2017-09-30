require 'serverspec'

# Required by serverspec
set :backend, :exec

## Use Junit formatter output, supported by jenkins
#require 'yarjuf'
#RSpec.configure do |c|
#    c.formatter = 'JUnit'
#end

lufi_reverseport = 1443

describe package('nginx') do
  it { should be_installed }
end

describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

describe port("#{lufi_reverseport}") do
  it { should be_listening }
end

describe command("curl -kvL https://localhost:#{lufi_reverseport}") do
  its(:stdout) { should match /<title>Let's Upload that FIle<\/title>/ }
  its(:stdout) { should match /Lufi/ }
  its(:stdout) { should match /Upload files/ }
  its(:stderr) { should match /X-Frame-Options: sameorigin/ }
  its(:stderr) { should match /X-XSS-Protection: 1; mode=block/ }
  its(:exit_status) { should eq 0 }
end

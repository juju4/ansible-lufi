require 'serverspec'

# Required by serverspec
set :backend, :exec

## Use Junit formatter output, supported by jenkins
#require 'yarjuf'
#RSpec.configure do |c|
#    c.formatter = 'JUnit'
#end

lufi_working_dir = "/var/www-lufi/src"
lufi_user = "www-lufi"

describe package('cpanminus'), :if => os[:family] == 'debian' || os[:family] == 'ubuntu' do
  it { should be_installed }
end
describe package('perl-App-cpanminus'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe service('lufi') do
  it { should be_enabled }
  it { should be_running }
end
describe process("#{lufi_working_dir}/script/lufi") do
  its(:user) { should eq "#{lufi_user}" }
  its(:args) { should match /lufi/ }
  its(:count) { should > 5 }
  it { should be_running }
end

describe file("#{lufi_working_dir}") do
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_owned_by "#{lufi_user}" }
end
describe file("#{lufi_working_dir}/files") do
  it { should be_directory }
  it { should be_mode 700 }
  it { should be_owned_by "#{lufi_user}" }
end
describe file("#{lufi_working_dir}/lufi.conf") do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by "#{lufi_user}" }
end
## only created at first upload? (centos7)
#describe file("#{lufi_working_dir}lufi.db") do
#  it { should be_file }
#  it { should be_mode 644 }
#  it { should be_owned_by "#{lufi_user}" }
#end
describe file("#{lufi_working_dir}/log/production.log") do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by "#{lufi_user}" }
end

describe port(8080) do
  it { should be_listening }
end

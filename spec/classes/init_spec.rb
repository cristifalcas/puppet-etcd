require 'spec_helper'

describe 'etcd' do
  context 'with defaults for all parameters on RedHat' do
    let :facts do
      {
        :kernel   => 'Linux',
        :osfamily => 'RedHat',
        :operatingsystemmajrelease => '7',
        :fqdn => 'my_hostname.domain.net',
        :ipaddress => '1.2.3.4',
      }
    end

    it { should contain_class('etcd') }
  end
end

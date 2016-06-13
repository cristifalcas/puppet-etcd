require 'spec_helper'

describe 'etcd', :type => :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge({:puppetversion => Puppet.version})
      end
      it 'test default install' do
        is_expected.to compile.with_all_deps
      end
    end
  end
end

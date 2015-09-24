require 'spec_helper'

describe 'rancid' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "rancid class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('rancid::params') }
        it { should contain_class('rancid::install').that_comes_before('rancid::config') }
        it { should contain_class('rancid::config') }
        it { should contain_class('rancid::service').that_subscribes_to('rancid::config') }

        it { should contain_service('rancid') }
        it { should contain_package('rancid').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'rancid class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('rancid') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end

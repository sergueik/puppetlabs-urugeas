require 'spec_helper'

describe 'ntp' do
  let(:facts) { { is_virtual: false } }

  let(:conf_path) do
    if defined?(os) and os =~ %r{solaris}
      '/etc/inet/ntp.conf'
    else
      '/etc/ntp.conf'
    end
  end
  it { is_expected.to compile.with_all_deps }

  it { is_expected.to contain_class('ntp::install') }
  it { is_expected.to contain_class('ntp::config') }
  it { is_expected.to contain_class('ntp::service') }

  describe 'ntp::config' do
    it { is_expected.to contain_file(conf_path).with_owner('0') }
    it { is_expected.to contain_file(conf_path).with_group('0') }
    it { is_expected.to contain_file(conf_path).with_mode('0644') }
  end
end

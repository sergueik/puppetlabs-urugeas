require 'spec_helper'

describe 'urugeas' do
  let(:facts) { { is_virtual: false } }

  let(:conf_path) do
    if defined?(os) and os =~ %r{solaris}
       '/etc/inet/urugeas.conf'
    else
      '/etc/urugeas.conf'
    end
  end
  it { is_expected.to compile.with_all_deps }

  it { is_expected.to contain_class('urugeas::defined_check') }
  it { is_expected.to_not contain_class('urugeas::cron_schedule') }

  it { is_expected.to contain_file('/var/lib/jenkins').with_ensure('directory').with({'ensure' => 'directory'}) }
  it { is_expected.to contain_file('/var/lib/jenkins/config_xml').with_ensure('file').with({'require' => 'File["/var/lib/jenkins"]','content' => 'dummy - will show the actual content'}) }
end

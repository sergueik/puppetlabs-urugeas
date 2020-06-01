require 'spec_helper'

describe 'urugeas' do
  context 'on Debian' do
    let(:facts) { {:osfamily => 'Debian'} }	
    let(:facts) { { is_virtual: false } }
    let(:facts) { { uptime_seconds: 120 } }
  
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
    # Ruby parameter
    config_dir = 'c:\jenkins' 
    it { is_expected.to contain_file( config_dir ).with_ensure('directory').with({'ensure' => 'directory'}) }
    # NOTE funny path separators. The code is never intended to operate on Windows in reality
    # NOTE: too much effort to cure the
    # Parameter path failed on File[...] 
    # File paths must be fully qualified
    it { is_expected.to contain_file("#{config_dir}/config_xml").with({ 'ensure'=>'file', 'require' => "File[#{config_dir}]"}) }
    it { is_expected.to contain_file("#{config_dir}/config_xml").with_content('dummy - will show the actual content') }
    xit { is_expected.to contain_file("#{config_dir}/config_xml").with_content(Regexp.new('^<hudson>.*$', Regexp::IGNORECASE|Regexp::MULTILINE)) }
    it { is_expected.to contain_file("#{config_dir}/config_xml").with_content(Regexp.new('<hudson>')).with_content(Regexp.new('<useSecurity>true</useSecurity>')) }
  end
end

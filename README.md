### Info

Dummified custom command Puppet module loosely based on [Puppet rspec tutorial intro](https://puppet.com/blog/unit-testing-rspec-puppet-for-beginners/)
used to construct in an r10k-disabled profile environment

### Testing

* prepare fixtures.
```sh
sudo gem install --no-rdoc --no-ri facter:2.4.6 rspec-puppet puppet-lint puppet puppet-syntax puppetlabs_spec_helper rspec-puppet-facts
```
certain gem versions (currently, `facter`) is critical to pin
NOTE: Can't use `--version` w/ multiple gems. Use `name:ver` instead

```
gem install --no-rdoc  --no-ri facter -v 2.4.6 puppet-rspec
```
collect dependency modules by hand, HEAD revisions
```sh
cd spec/fixtures/modules
git clone https://github.com/puppetlabs/puppetlabs-stdlib stdlib
git clone https://github.com/voxpupuli/puppet-cron cron
```
On Windows host, may hane to manuallly prepare link to main module
by executing the following command in elevated console:
```cmd
mklink  /D spec\fixtures\modules\urugeas c:\developer\sergueik\puppetlabs-urugeas
```
### Practical usage
#### Facts-Based Behavior
Puppet spec is handy e.g. for tracking introduced or pruned dependencis across deep and complex 
role / profile provisions which are time-consuming or impossible *in vitro*, 
e.g. by requring multipe connected roles be brought up healthy in Vagrant.
This is similar to classic Puppet case (in pseudocode):
```Ruby
require 'spec_helper'

describe 'module' do
  on_supported_os.each do |os, facts|
    context os, if: facts[:osfamily] == 'Debian' do
      let(:facts) { facts }
      if facts[:operatingsystem] == 'Ubuntu'
        it do
          is_expected.to contain_something('name of the resource').with(
            'some_attribute' => 'some value'
          end
        }
      else
        it { is_expected.to contain_something_completely_different('name of the resource') }
      end
    end
  end
end
```
naturally instead of the `$::os` fact one sure can exercise the "code" dependency
on whatever business-specific fact it is

#### Examine Contents of Generated Resources
Thanks the famous Puppet / Chef introduced segregation between "code" (in manifests contain), templates and resource, and parameteres (hieradata)
often a full node provision is exercised just to see how the generated systemd unit or XML configuration file would look like.
```Ruby
define custom_resource_generator (
  Variant[String, Undef] $parameter = undef,
) {

  notify {"${name} parameter = ${parameter}":
    message => "parameter = ${parameter}",
  }

```
To find out that information:
```Ruby
describe 'custom_resource_generator' do
  context 'compose resource using type name and parameters' do
    let(:title) { 'test' }

    context 'and parameters are provided' do
      let(:params) { 
        {
          :parameter => 'parameter1',
        } 
      }
      it do 
        should contain_notify('test parameter = parameter1')
          .with_message('parameter = parameter1') 
      end
    end
  end
end

```

### TODO

* handle past error: `fatal: could not lookup name for submodule 'spec/fixtures/modules/cron'` 

### See Also

 * [Docker-based](https://github.com/gregswift/docker-rspec-puppet/blob/master/puppet4/Dockerfile)

### License
This project is licensed under the terms of the MIT license.

### Author
[Serguei Kouzmine](kouzmine_serguei@yahoo.com)

### Used to construct when r10k disabled

 * [](https://puppet.com/blog/unit-testing-rspec-puppet-for-beginners/)
prepare fixtures
```
gem install --no-rdoc--no-ri facter -v 2.4.6
gem install --no-rdoc  --no-ri puppet-rspec
git clone https://github.com/puppetlabs/puppetlabs-stdlib stdlib
git clone https://github.com/voxpupuli/puppet-cron cron
```
prepare link to main module
```
mklink  /D spec\fixtures\modules\urugeas c:\developer\sergueik\puppetlabs-urugeas
```
### See Also

 * [Docker-based](https://github.com/gregswift/docker-rspec-puppet/blob/master/puppet4/Dockerfile)

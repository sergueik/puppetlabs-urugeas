### Info

Downsized puppet module with spec used to serve as a container for module composing custom commands when r10k disabled, so filling fitures manually


 * [pupet document coveryng the basics](https://puppet.com/blog/unit-testing-rspec-puppet-for-beginners/)
 * original [pupptlabs ntp](https://github.com/puppetlabs/puppetlabs-ntp) module

### It is a mix of pseudo-object oriented and convention over configuration approach
```sh
spec/fixtures/modules
ntp@
```
```sh
ls -ld ntp
lrwxrwxrwx 1 Serguei 197609 51 May 31 16:40 ntp -> /c/developer/sergueik/puppetlabs-urugeas/origin/xxx/
```
```
pushd spec/fixtures/modules 
git clone https://github.com/puppetlabs/puppetlabs-stdlib stdlib
ln
```
### License
This project is licensed under the terms of the MIT license.

### Author
[Serguei Kouzmine](kouzmine_serguei@yahoo.com)

# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.define :centos do |c|
    c.vm.hostname = 'centos'
    c.vm.box = 'linyows/centos-7.1_chef-12.2_puppet-3.7'
    c.vm.provision :chef_zero do |chef|
      chef.cookbooks_path = %w(vendor/cookbooks)
      #chef.add_recipe 'nginxxx::sticky_module'
      chef.add_recipe 'nginxxx'
      #chef.json = { nginxxx: { build: true } }
    end
  end
end

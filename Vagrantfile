# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = 'ubuntu/xenial64'

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = %w(cookbooks vendor/cookbooks)
    chef.add_recipe 'nginxxx'
    #chef.json = {
    #  nginxxx: {
    #  }
    #}
  end
end

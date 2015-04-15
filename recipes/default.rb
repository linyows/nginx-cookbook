# Cookbook Name:: nginxxx
# Recipe:: default

if node['nginxxx']['build']
  include_recipe 'nginxxx::source'
else
  include_recipe 'nginxxx::repository'

  package 'nginx' do
    version "#{node['nginxxx']['version']}-#{node['nginxxx']['release']}"
    action :install
    options '--disablerepo=* --enablerepo=nginx'
  end
end

include_recipe 'nginxxx::directory'
include_recipe 'nginxxx::config'

service 'nginx' do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end

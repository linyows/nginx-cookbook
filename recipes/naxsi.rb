# Cookbook Name:: nginxxx
# Recipe:: naxsi

cache_path = Chef::Config[:file_cache_path]

remote_file "/usr/local/src/naxsi-#{node['nginxxx']['naxsi']['version']}.tar.gz" do
  source "https://github.com/nbs-system/naxsi/archive/#{node['nginxxx']['naxsi']['version']}.tar.gz"
  notifies :run, 'execute[unpack_naxsi]', :immediately
end

execute 'unpack_naxsi' do
  command "tar xf naxsi-#{node['nginxxx']['naxsi']['version']}.tar.gz"
  cwd '/usr/local/src'
  action :nothing
end

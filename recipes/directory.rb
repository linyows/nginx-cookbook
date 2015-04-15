# Cookbook Name:: nginxxx
# Recipe:: directory

%w(
  /etc/nginx
  /var/cache/nginx
).each do |path|
  directory path do
    owner 'root'
    group node['root_group']
    mode '0755'
    recursive true
  end
end

directory '/var/log/nginx' do
  owner node['nginxxx']['user']
  mode '0755'
  recursive true
end

directory File.dirname(node['nginxxx']['pid']) do
  owner 'root'
  group node['root_group']
  mode '0755'
  recursive true
end

%w(
  sites-available
  sites-enabled
  conf.d
).each do |dir_name|
  directory "/etc/nginx/#{dir_name}" do
    owner 'root'
    group node['root_group']
    mode  '0755'
  end
end

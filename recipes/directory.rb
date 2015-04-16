# Cookbook Name:: nginxxx
# Recipe:: directory

[
  node['nginxxx']['dir'],
  node['nginxxx']['cache']
].each do |path|
  directory path do
    owner 'root'
    group node['root_group']
    mode '0755'
    recursive true
  end
end

directory node['nginxxx']['log'] do
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
  directory "#{node['nginxxx']['dir']}/#{dir_name}" do
    owner 'root'
    group node['root_group']
    mode  '0755'
  end
end

link "#{node['nginxxx']['dir']}/logs" do
  to "#{node['nginxxx']['log']}"
end

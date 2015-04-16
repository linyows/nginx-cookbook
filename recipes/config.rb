# Cookbook Name:: nginxxx
# Recipe:: config

template "#{node['nginxxx']['dir']}/nginx.conf" do
  source 'nginx.conf.erb'
  cookbook node['nginxxx']['conf_cookbook']
  owner 'root'
  group 'root'
  mode '0644'
  notifies :reload, 'service[nginx]', :delayed
end

%w(
  default.conf
  example_ssl.conf
).each do |file|
  file "#{node['nginxxx']['dir']}/conf.d/#{file}" do
    action :delete
    notifies :reload, 'service[nginx]', :delayed
    only_if "test -f #{node['nginxxx']['dir']}/conf.d/#{file}"
  end
end

template "#{node['nginxxx']['dir']}/sites-available/default" do
  source 'nginx.default_site.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :reload, 'service[nginx]', :delayed
end

if node['nginxxx']['default_site']
  link "#{node['nginxxx']['dir']}/sites-enabled/default" do
    to "#{node['nginxxx']['dir']}/sites-available/default"
  end
end

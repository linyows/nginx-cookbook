# Cookbook Name:: nginxxx
# Recipe:: config

template '/etc/nginx/nginx.conf' do
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
  file "/etc/nginx/conf.d/#{file}" do
    action :delete
    notifies :reload, 'service[nginx]', :delayed
    only_if "test -f /etc/nginx/conf.d/#{file}"
  end
end

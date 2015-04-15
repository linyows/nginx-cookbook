# Cookbook Name:: nginxxx
# Recipe:: config

cookbook_file 'init.sh' do
  path '/etc/init.d/nginx'
  source 'init.sh'
  cookbook node['nginxxx']['init_cookbook']
  owner 'root'
  group 'root'
  mode '0755'
end

cookbook_file 'nginx.conf' do
  path '/etc/nginx/nginx.conf'
  source 'nginx.conf'
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

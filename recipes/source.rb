# Cookbook Name:: nginxxx
# Recipe:: source

nginx_version = node['nginxxx']['version']
cache_path = Chef::Config[:file_cache_path]

include_recipe 'build-essential::default'

%w(
  pcre-devel
  openssl-devel
).each { |name| package name }

remote_file "#{cache_path}/nginx-#{nginx_version}.tar.gz" do
  source "http://nginx.org/download/nginx-#{nginx_version}.tar.gz"
  action :create_if_missing
end

bash "expand nginx-#{nginx_version}" do
  not_if "test -d #{cache_path}/nginx-#{nginx_version}"
  code <<-CODE
    cd "#{cache_path}"
    tar xvf nginx-#{nginx_version}.tar.gz
  CODE
end

template "#{cache_path}/nginx-#{nginx_version}/configure_with_options" do
  source 'nginx.configure_with_options.erb'
  cookbook node['nginxxx']['configure_cookbook']
  mode '0755'
end

bash "install nginx-#{nginx_version}" do
  code <<-CODE
    cd #{cache_path}/nginx-#{nginx_version}
    ./configure_with_options
    make && make install
  CODE
  not_if "nginx -v 2>&1 | grep -q #{nginx_version}"
end

if node['platform_family'] == 'rhel' && node['platform_version'].to_i >= 7
  template '/usr/lib/systemd/system/nginx.service' do
    source 'nginx.service.erb'
    owner 'root'
    group node['root_group']
    mode '0755'
    cookbook node['nginxxx']['init_cookbook']
  end
else
  template '/etc/init.d/nginx' do
    source 'nginx.init.erb'
    owner 'root'
    group node['root_group']
    mode '0755'
    cookbook node['nginxxx']['init_cookbook']
  end
end

template node['nginxxx']['sysconfig'] do
  source 'nginx.sysconfig.erb'
  owner  'root'
  group  node['root_group']
  mode   '0644'
end

user node['nginxxx']['user'] do
  system true
  shell '/bin/false'
  home '/var/www'
end

bash "mv #{node['nginxxx']['dir']}/html /usr/share/nginx/html" do
  code <<-CODE
    mkdir -p /usr/share/nginx
    mv #{node['nginxxx']['dir']}/html /usr/share/nginx/html
  CODE
  not_if "test -d /usr/share/nginx/html"
end

template '/etc/logrotate.d/nginx' do
  source 'nginx.logrotate.erb'
  owner  'root'
  group  node['root_group']
  mode   '0644'
  cookbook node['nginxxx']['logrotate_cookbook']
end

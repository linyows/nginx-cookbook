# Cookbook Name:: nginxxx
# Recipe:: source

nginx_version = node['nginxxx']['version']
cache_path = Chef::Config[:file_cache_path]

include_recipe 'build-essential::default'

%w(
  pcre-devel
  openssl-devel
  tar
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

cookbook_file "#{cache_path}/nginx-#{nginx_version}/configure_with_options" do
  source 'configure_with_options'
  mode '0755'
end

bash "install nginx-#{nginx_version}" do
  code <<-CODE
    cd #{cache_path}/nginx-#{nginx_version}
    ./configure_with_options
    make && make install
  CODE
  not_if "which nginx"
end

user node['nginxxx']['user'] do
  system true
  shell '/bin/false'
  home '/var/www'
end

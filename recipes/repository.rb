# Cookbook Name:: nginxxx
# Recipe:: repository

case node['platform_family']
when 'rhel', 'fedora'
  include_recipe 'yum::default'

  yum_repository 'nginx' do
    description 'Nginx.org Repository'
    baseurl node['nginxxx']['repository']
    gpgkey 'http://nginx.org/keys/nginx_signing.key'
    action :create
  end

when 'debian'
  include_recipe 'apt::default'

  apt_repository 'nginx' do
    uri node['nginxxx']['repository']
    distribution node['lsb']['codename']
    components %w(nginx)
    deb_src true
    key 'http://nginx.org/keys/nginx_signing.key'
  end
end

# Cookbook Name:: nginxxx
# Attributes:: default

default['nginxxx']['version']       = '1.7.12'
default['nginxxx']['release']       = '1.el7.ngx'
default['nginxxx']['build']         = false

default['nginxxx']['init_cookbook'] = 'nginxxx'
default['nginxxx']['conf_cookbook'] = 'nginxxx'

default['nginxxx']['pid'] = '/var/run/nginx.pid'

case node['platform_family']
when 'rhel', 'fedora'
  default['nginxxx']['repository'] = "http://nginx.org/packages/mainline/centos/#{node['platform_version'].to_i}/$basearch/"
  default['nginxxx']['user'] = 'nginx'
  default['nginxxx']['sysconfig'] = '/etc/sysconfig/nginx'
when 'debian'
  default['nginxxx']['repository'] = "http://nginx.org/packages/#{node['platform']}"
  default['nginxxx']['user'] = 'www-data'
  default['nginxxx']['sysconfig'] = '/etc/default/nginx'
  if platform == 'ubuntu' && platform_version >= '14.04'
    default['nginx']['pid'] = '/run/nginx.pid'
  end
end

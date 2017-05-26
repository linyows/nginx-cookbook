# Cookbook Name:: nginxxx
# Attributes:: default

default['nginxxx']['version']            = '1.12.0'
-
default['nginxxx']['build']              = false
default['nginxxx']['default_site']       = true

default['nginxxx']['init_cookbook']      = 'nginxxx'
default['nginxxx']['conf_cookbook']      = 'nginxxx'
default['nginxxx']['configure_cookbook'] = 'nginxxx'
default['nginxxx']['logrotate_cookbook'] = 'nginxxx'

default['nginxxx']['dir']                = '/etc/nginx'
default['nginxxx']['pid']                = '/var/run/nginx.pid'
default['nginxxx']['lock']               = '/var/run/nginx.lock'
default['nginxxx']['log']                = '/var/log/nginx'
default['nginxxx']['cache']              = '/var/cache/nginx'

case node['platform_family']
when 'rhel', 'fedora'
  default['nginxxx']['repository'] = "http://nginx.org/packages/mainline/centos/#{node['platform_version'].to_i}/$basearch/"
  default['nginxxx']['user'] = 'nginx'
  default['nginxxx']['sysconfig'] = '/etc/sysconfig/nginx'
  if node['platform'] == 'centos' && node['platform_version'] >= '7'
    default['nginxxx']['pid']  = '/run/nginx.pid'
    default['nginxxx']['lock'] = '/run/nginx.lock'
  end
  default['nginxxx']['release'] = "1.el#{node['platform_version'].to_i}.ngx"
when 'debian'
  default['nginxxx']['repository'] = "http://nginx.org/packages/#{node['platform']}"
  default['nginxxx']['user'] = 'www-data'
  default['nginxxx']['sysconfig'] = '/etc/default/nginx'
  if node['platform'] == 'ubuntu' && node['platform_version'] >= '14.04'
    default['nginxxx']['pid']  = '/run/nginx.pid'
    default['nginxxx']['lock'] = '/run/nginx.lock'
  end
  default['nginxxx']['release'] = "1~#{node['lsb']['codename']}"
end

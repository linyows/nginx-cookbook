# Cookbook Name:: nginxxx
# Recipe:: modsecurity

version = node['nginxxx']['modsecurity']['version']

packages = case node['platform_family']
when 'rhel', 'fedora'
  %w(
    git
    libtool
    pcre-devel
    curl-devel
    httpd-devel
    libxml2-devel
    gcc-c++
  )
when 'debian'
  %w(
    git
    libtool
    libcurl-dev
    pcre-dev
    apache2-prefork-dev
    libxml2-dev
    g++
  )
end

packages.each do |name|
  package name
end

cache_path = Chef::Config[:file_cache_path]

%w(
  modsecurity
  modsecurity-nginx
  modsecurity-ruleset
).each do |n|
  git "/usr/local/src/#{n}" do
    repository node['nginxxx'][n]['repository']
    revision   node['nginxxx'][n]['branch']
    action :sync
  end
end

execute 'make_modsecurity' do
  not_if 'test -d /usr/local/modsecurity' unless node['nginxxx']['modsecurity']['force_build']
  command <<-EOS
  make clean
  sh build.sh
  git submodule init
  git submodule update
  ./configure
  make
  make install
  EOS
  environment 'CFLAGS' => "-DDEFAULT_USER=\\\"#{node['nginxxx']['user']}\\\" -DDEFAULT_GROUP=\\\"#{node['nginxxx']['user']}\\\""
  cwd "/usr/local/src/modsecurity"
end

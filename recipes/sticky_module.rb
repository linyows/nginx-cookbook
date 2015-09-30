# Cookbook Name:: nginxxx
# Recipe:: stikcy_module

stikcy_module_version = node['nginxxx']['sticky_module']['version']
stikcy_module_hash = node['nginxxx']['sticky_module']['hash']

cache_path = Chef::Config[:file_cache_path]

remote_file "#{cache_path}/nginx-sticky-module-ng-#{stikcy_module_version}.tar.gz" do
  source "https://bitbucket.org/nginx-goodies/nginx-sticky-module-ng/get/#{stikcy_module_version}.tar.gz"
  action :create_if_missing
end

bash 'expand nginx-sticky-module-ng' do
  not_if "test -d #{cache_path}/nginx-sticky-module-#{stikcy_module_version}"
  code <<-CODE
    cd "#{cache_path}"
    tar xvf nginx-sticky-module-ng-#{stikcy_module_version}.tar.gz
    mv nginx-goodies-nginx-sticky-module-ng-#{stikcy_module_hash} nginx-sticky-module-#{stikcy_module_version}
  CODE
end

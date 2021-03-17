# Cookbook Name:: nginxxx
# Attributes:: modsecurity

default['nginxxx']['modsecurity']['repository'] = 'https://github.com/SpiderLabs/ModSecurity'
default['nginxxx']['modsecurity']['branch'] = 'v3/master'
default['nginxxx']['modsecurity']['force_build'] = false
default['nginxxx']['modsecurity-nginx']['repository'] = 'https://github.com/SpiderLabs/ModSecurity-nginx'
default['nginxxx']['modsecurity-nginx']['branch'] = 'master'
default['nginxxx']['modsecurity-ruleset']['repository'] = 'https://github.com/coreruleset/coreruleset'
default['nginxxx']['modsecurity-ruleset']['branch'] = 'v3.3/master'

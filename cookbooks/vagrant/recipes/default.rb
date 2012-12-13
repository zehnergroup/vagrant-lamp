include_recipe "apt"
include_recipe "apache2"
include_recipe "apache2::mod_rewrite"
include_recipe "apache2::mod_ssl"
include_recipe "mysql::server"
include_recipe "php"
include_recipe "apache2::mod_php5"

# Update Apache's user and group
# I couldn't found an easear way and I don't want to edit opscode's cookbook
bash "update_apache_user_group" do
  user "root"
  cwd  "#{node['apache']['dir']}"
  code <<-EOH
  cat /etc/apache2/apache2.conf |
  sed 's/User www-data/User vagrant/g' |
  sed 's/Group www-data/Group vagrant/g' \
  > apache2.conf.tmp
  mv apache2.conf.tmp apache2.conf
  EOH
end
service "apache2" do
  supports :restart => true, :reload => true
  action :enable
end

# Install packages
%w{ debconf }.each do |a_package|
  package a_package
end

# Generate selfsigned ssl
execute "make-ssl-cert" do
  command "make-ssl-cert generate-default-snakeoil --force-overwrite"
  ignore_failure true
  action :nothing
end

# Initialize sites data bag
sites = []
begin
  sites = data_bag("sites")
rescue
  puts "Sites data bag is empty"
end

# Configure sites
sites.each do |name|
  site = data_bag_item("sites", name)

  # Add site to apache config
  web_app site["host"] do
    template "sites.conf.erb"
    server_name site["host"]
    server_aliases site["aliases"]
    docroot "/home/vagrant/#{site["host"]}"
  end

   # Add site info in /etc/hosts
   bash "hosts" do
     code "echo 127.0.0.1 #{site["host"]} #{site["aliases"].join(' ')} >> /etc/hosts"
   end
end

# Disable default site
apache_site "default" do
  enable false
end

# Install php5-mysql
package "php5-mysql" do
  action :install
end

# Install php5-xsl
package "php5-xsl" do
  action :install
end

# Install php5-gd
package "php5-gd" do
  action :install
end

# Install php5-curl
package "php5-curl" do
  action :install
end

# Install Xdebug
php_pear "xdebug" do
  action :install
end
template "#{node['php']['ext_conf_dir']}/xdebug.ini" do
  source "xdebug.ini.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
  notifies :restart, resources("service[apache2]"), :delayed
end

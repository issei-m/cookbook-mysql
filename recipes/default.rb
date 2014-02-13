#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2013, Issei Murasawa <issei.m7@gmail.com>
#

execute 'remove-installed-mysql' do
  command 'yum remove -y mysql*'
  only_if 'yum list installed | grep mysql*'
end

node['mysql']['rpms'].each do |rpm|
  remote_file "#{Chef::Config[:file_cache_path]}/#{rpm[:file]}" do
    source "#{rpm[:url]}"
    action :create
  end

  package "#{rpm[:package_name]}" do
    action :install
    provider Chef::Provider::Package::Rpm
    source "#{Chef::Config[:file_cache_path]}/#{rpm[:file]}"
  end
end

template '/usr/my.cnf' do
  source 'my.cnf.erb'
  mode 0644
  owner 'root'
  group 'root'
end

service 'mysql' do
  action [:start, :enable]
end

bash 'set-mysql-password' do
  action :run
  user 'root'
  code <<-EOF
    export NEW_PASSWD=#{node['mysql']['root_password']}
    export OLD_PASSWD=`head -n 1 /root/.mysql_secret | awk '{print $(NF - 0)}'`
    mysql -u root -p${OLD_PASSWD} --connect-expired-password -e "SET PASSWORD FOR 'root'@'localhost'=PASSWORD('${NEW_PASSWD}');" 
    mysql -u root -p${NEW_PASSWD} --connect-expired-password -e "SET PASSWORD FOR 'root'@'127.0.0.1'=PASSWORD('${NEW_PASSWD}');"
    mysql -u root -p${NEW_PASSWD} --connect-expired-password -e "SET PASSWORD FOR 'root'@'::1'=PASSWORD('${NEW_PASSWD}');"
    mysql -u root -p${NEW_PASSWD} --connect-expired-password -e "DROP USER 'root'@'localhost.localdomain';"
    mysql -u root -p${NEW_PASSWD} --connect-expired-password -e "GRANT ALL ON *.* TO 'root'@'192.168.33.%' IDENTIFIED BY '${NEW_PASSWD}';"
    mysql -u root -p${NEW_PASSWD} --connect-expired-password -e "GRANT ALL ON *.* TO 'root'@'10.0.%' IDENTIFIED BY '${NEW_PASSWD}';"
    mysql -u root -p${NEW_PASSWD} --connect-expired-password -e "FLUSH PRIVILEGES;"
    rm -f /root/.mysql_secret
  EOF
  only_if { File.exists?('/root/.mysql_secret') }
end

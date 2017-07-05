# Cookbook Name:: mytomcat
gem_package "ruby-shadow" do
  action :install
end
 
# Create a unix group
group "webadmin" do
     gid 100001
end
 
# To create an encrypted password use the following:
# openssl passwd -1 "theplaintextpassword"
 
# Create a unix user
user "webadmin" do
     comment "Web Administrator"
     uid 10001
     gid "web"
     home "/home/webadmin"
     shell "/bin/bash"
     password "11111"
end
 
# Create a directory
directory "/opt/apps/" do
     owner "webadmin"
     group "web"
     mode "0755"
     action :create
     recursive true
end
 
# Run a bash shell -  download and extract tomcat
bash "install_tomcat" do
     user "root"
     cwd "/opt/apps"
     code <<-EOH
       wget http://mirrors.ibiblio.org/apache/tomcat/tomcat-7/v7.0.27/bin/apache-tomcat-7.0.27.tar.gz
       tar -xzf apache-tomcat-7.0.27.tar.gz
       chown -R webadmin:webadmin /opt/apps
     EOH
     not_if "test -d /opt/apps/apache-tomcat-7.0.27"
end
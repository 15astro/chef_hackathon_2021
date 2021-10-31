#
# Cookbook:: service_attacks
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

factsbook_app_ip = node["factsbook_app_ip"]
db_port = node["db_port"]

execute "Block incoming connections on mongo server" do
 command "sudo iptables -A INPUT -i eth0 -p tcp --destination-port #{db_port} -s #{factsbook_app_ip}  -j DROP"
end

chef_sleep 'Keep the port blocked for 60 seconds' do
  seconds 60
end

execute "Unblock the iptables rule" do
 command "iptables -D INPUT -i eth0 -p tcp --destination-port #{db_port} -s #{factsbook_app_ip}  -j DROP"
end



#
# Cookbook:: service_attacks
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

execute "shutdown sever" do
 command "shutdown now 'This server is shtting down for chaos'"
end

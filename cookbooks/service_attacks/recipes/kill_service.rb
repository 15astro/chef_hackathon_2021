#
# Cookbook:: service_attacks
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.
process_name = node["process_name"]

execute "kill process" do
 command "pkill -f  #{process_name}"
end

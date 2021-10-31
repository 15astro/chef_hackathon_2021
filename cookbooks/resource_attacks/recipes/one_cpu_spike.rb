#
# Cookbook:: service_attacks
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

core_to_use = 1

execute "generate CPU spikes using bash" do
 command "while [#{core_to_use} -gt 0]; do let #{core_to_use}=#{core_to_use} - 1; done" 
end

chef_sleep 'wait for the CPU spike to continue' do
  seconds 60
end

execute "Stop the CPU spikes created in step 1" do
 command "pkill -f 'sh -c'"
end

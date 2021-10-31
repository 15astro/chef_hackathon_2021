#
# Cookbook:: service_attacks
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

total_cpu_cores = node["cpu"]["cpus"]

execute "generate CPU spikes using bash" do
 command "for i in {1..#{total_cpu_cores}; do while : ; do : ; done & done"
end

chef_sleep 'wait for the CPU spike to continue' do
  seconds 60
end

execute "Stop the CPU spikes created in step 1" do
 command "pkill -f 'sh -c'"
end

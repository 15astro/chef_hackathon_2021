#
# Cookbook:: service_attacks
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

redis_docker_id = node["redis_docker_id"]

execute "Simulate latency in redis cache layer using sleep calls" do
 command "docker exec -i #{redis_docker_id} redis-cli DEBUG SLEEP 30"
end

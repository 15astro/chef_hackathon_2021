#
# Cookbook:: service_attacks
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

execute "Stepdown mongodb primary" do
 command "mongo --eval 'rs.stepDown()'"
end

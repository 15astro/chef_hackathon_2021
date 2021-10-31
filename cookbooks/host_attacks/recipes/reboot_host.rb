#
# Cookbook:: service_attacks
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

reboot 'now' do
  action :request_reboot
  reason 'Rebooting this server for chaos'
end

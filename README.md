This project was submitted to [Automate for Good by Chef](https://chef-hackathon.devpost.com/)

# Automating for Failures - Chaos Engineering with Chef

## About this Project:
Failures happen in large distributed systems. We have seen recent worldwide outage of Facebook, Instagram, and WhatsApp. Fastly's outage happened mid this year and Google's outage at end of 2020. Failures happen!

But, can we identify these failures proactively? Chaos Engineering has been practiced widely to solve this problem. With Chef, we are automating the Chaos Engineering experiments that create turbulent attacks in your system to:

- Build confidence in your systems
- Uncover point of failures
- Detect failures proactively

## What it does:
Our project - Automating for Failures, uses Chef Infra to automate the attacks on your system hosted on AWS, Google Cloud, or in your own infrastructure. These attacks generate several turbulent conditions in your system like:

- Rebooting servers
- Stoping services
- Killing running processes
- Blocking networks
- Simulating a failover in the database
- Using all of the server's CPU cores
- List goes on

## How we built it:
Our Chaos Attacks Pipeline involves following components:

- Chef Workstation: Develop and test attacks
- Managed Chef server: Manage cookbooks, roles, policies, and nodes
- Chef nodes: Run chef-client to trigger attacks

## Chef + Chaos Engineering:

#### Chaos Principles(Advanced):
Reference: https://principlesofchaos.org/

1. Build a Hypothesis around Steady State Behavior
2. Vary Real-world Events
3. Run Experiments in Production
4. Automate Experiments to Run Continuously
5. Minimize Blast Radius

With this project, our goal is to attempt one the Chaos Engineering principle with Chef - 
> **Automate Experiments to Run Continuously**

## High Level Design:

The following approach explains how we strctured our cookbooks & recipes to enable code-reusability as well as cohesion

1. **Host Level Attacks**:
 - Cookbook: host_attacks
   - Recipes - Reboot, shutdown, terminate, block_network

2. **Service Level Attacks**:
 - Cookbook: service_attacks
   - Recipes - stop, restart, kill

3. **Server Resource Level Attacks**:
 - Cookbook: resource_attacks
   - Recipes -CPU, Memory, IO, Disk

4. **MongoDB Attacks**:
 - Cookbook: mongo_attacks
   - Recipes: exhaust_connections, stepdown primary, kill primary, kill 

5. **Redis Attacks**:
 - Cookbook: redis_attacks
   - Recipes: sleep server, saturate IOPS, stop service

6. **Cassandra Attacks**: WIP
 - Cookbook: cassandra_attacks
   - Recipes: stop_majority_nodes in 1 DC, stop 1 node, stop all nodes in DC

## How to use this project:
1. Clone this github repo: ```git clone https://github.com/150astro/chef_autoamte_for_good.git```
3. Upload the cookbooks you're interested in to your Chef server using:
    - ```knife upload cookbooks/chaos_attacks/cookbooks/host_attacks```
    - ```knife upload cookbooks/chaos_attacks/cookbooks/service_attacks```
    - ```knife upload cookbooks/chaos_attacks/cookbooks/resource_attacks```
    - ```knife upload cookbooks/chaos_attacks/cookbooks/redis_attacks```
    - ```knife upload cookbooks/chaos_attacks/cookbooks/mongodb_attacks```
5. Bootstrap your nodes to Chef server if you haven't already:
    - ```knife bootstrap <node_fqdn> -x <host_username> -i <host_key_file_name> --sudo --node-name <node_name_of_your_choice> -r "recipe[starter::default]"```

## How to test an attack: 
   Please test the attacks only on your test nodes
### Example: Run attack to reboot your host - 
1. Select the name of cookbook you want to run the attack from. Example: host_attacks
2. Choose the attack you want to simulate on the node. Example: reboot
3. The recipe name is derived from the name of the attack: Example - for reboot attack the recipe to use is reboot_host.rb
4. Test recipe from the node: 
   ```chef-client -o 'recipe[host_attacks::reboot_host]'```
5. On successful run of the chef-client, the node will be rebooted.

### Example: Run attack to consume all CPU cores on node
1. Select the name of cookbook you want to run the attack from. Example: resource_attacks
2. Choose the attack you want to simulate on the node. Example: 
3. The recipe name is derived from the name of the attack: Example - for all_cpu_spikes it will be all_cpu_spikes.rb
4. Test recipe from the node: 
   ```chef-client -o 'recipe[resource_attacks::all_cpu_spikes]'```
5. On successful run of the chef-client, the node will have all of it's CPU cores used upto 100% for 60 seconds. 

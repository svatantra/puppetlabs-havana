Setup for a two node OpenStack deployment

##Setup Details

Common configurations can be found in common.yaml, Controller specific configuration details are in controller.dev.com.yaml, and Compute specific configurations are in compute.dev.com.yaml.

Here, Controller Node also functions as a Compute Node. 

network_vlan_ranges and physical_interface_mappings are the two neutron properties that can vary across different types of nodes.



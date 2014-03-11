# The profile to set up the neutron server
class havana::profile::neutron::server {
  havana::resources::controller { 'neutron': }
  havana::resources::database { 'neutron': }
  havana::resources::firewall { 'Neutron API': port => '9696', }

  class { '::neutron::keystone::auth':
    password         => hiera('havana::neutron::password'),
    public_address   => hiera('havana::controller::address::api'),
    admin_address    => hiera('havana::controller::address::management'),
    internal_address => hiera('havana::controller::address::management'),
    region           => hiera('havana::region'),
  }

  class { '::neutron::server':
    auth_host     => hiera('havana::controller::address::management'),
    auth_password => hiera('havana::neutron::password'),
    enabled       => true,
  }
  
  //TODO-SV, check for OpenVswitch
  class { '::neutron':
    core_plugin   => 'linuxbridge',
  }

  include ::havana::common::neutron
}

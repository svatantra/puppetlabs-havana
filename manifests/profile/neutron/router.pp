# The profile to set up a neutron ovs network router
class havana::profile::neutron::router {
  Exec { 
    path => '/usr/bin:/usr/sbin:/bin:/sbin', 
    require => Class['havana::profile::neutron::common'],
  } 
  
  ::sysctl::value { 'net.ipv4.ip_forward': 
    value     => '1',
  }

  $controller_management_address = hiera('havana::controller::address::management')
  include ::havana::common::neutron

  ### Router service installation
  class { '::neutron::agents::l3':
    debug   => hiera('havana::debug'),
    enabled => true,
  }

  class { '::neutron::agents::dhcp':
    debug   => hiera('havana::debug'),
    enabled => true,
  }

  class { '::neutron::agents::metadata':
    auth_password => hiera('havana::neutron::password'),
    shared_secret => hiera('havana::neutron::shared_secret'),
    auth_url      => "http://${controller_management_address}:35357/v2.0",
    debug         => hiera('havana::debug'),
    auth_region   => hiera('havana::region'),
    metadata_ip   => $controller_management_address,
    enabled       => true,
  }

  # Temporarily fix a bug on RHEL packaging
  if $::osfamily == 'RedHat' {
    file { '/usr/lib/python2.6/site-packages/neutronclient/client.py':
      ensure  => present,
      source  => 'puppet:///modules/havana/client.py',
      mode    => '0644',
      notify  => Service['neutron-metadata-agent'],
      require => Package['openstack-neutron'],
    }
  }

# TODO-SV, To check if bridge is required for Linux Bridge
#  vs_bridge { 'br-ex':
#    ensure => present,
#  }

#  $external_network = hiera('havana::network::external')
#  $external_device = device_for_network($external_network)

#  vs_port { $external_device:
#    ensure  => present,
#    bridge  => 'br-ex',
#    keep_ip => true,
#  }
}

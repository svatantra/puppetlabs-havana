#!/bin/bash
# Set up the Puppet Master

"sudo service iptables stop; \
sudo puppet module install puppetlabs/puppetdb; \
sudo puppet module install puppetlabs/ntp; \
sudo puppet module install puppetlabs/mysql --version 0.6.1; \
sudo puppet module install puppetlabs/openstack; \
sudo puppet module install puppetlabs/mongodb; \
sudo cp /etc/puppet/modules/havana/examples/allinone/site.pp /etc/puppet/manifests/site.pp; \
sudo chown root:puppet /etc/puppet/manifests/site.pp; \
sudo service puppetmaster start;\
sudo puppet agent -t;"

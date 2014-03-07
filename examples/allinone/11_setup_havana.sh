#!/bin/bash
# Move the Havana module to the Puppet Master
"cd /etc/puppet/modules; \
sudo cp /etc/puppet/modules/havana/examples/hiera.yaml /etc/puppet/hiera.yaml; \
sudo chown root:puppet /etc/puppet/hiera.yaml; \
sudo mkdir /etc/puppet/hieradata; \
sudo chown root:puppet /etc/puppet/hieradata; \
sudo cp /etc/puppet/modules/havana/examples/allinone.yaml /etc/puppet/hieradata/common.yaml; \
sudo chown root:puppet /etc/puppet/hieradata/common.yaml; \
sudo service puppetmaster restart;"

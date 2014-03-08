node 'master.master.com' {
  include ::ntp
}

node 'controller.dev.com' {
  include ::havana::role::allinone
}

node 'compute.dev.com' {
  include ::havana::role::compute
}

node 'master' {
  include ::ntp
}

node 'slave' {
  include ::havana::role::allinone
}

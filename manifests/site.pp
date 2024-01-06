class install_nginx {
  package { 'nginx':
    ensure => installed,
    name => 'nginx',
    provider => 'yum',
    }
}
class reload_nginx {
  service { 'nginx':
    ensure => running,
    enable => true,
  }
}
class firewall {
  

}

node 'slave1.puppet' {
  include install_nginx, reload_nginx
}

node 'slave2.puppet' {
  include install_nginx, reload_nginx
}

toryclass install_nginx {
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
    package { 'nginx':
    ensure => installed,
    name => 'nginx',
    provider => 'yum',
    }
    -> file { 'Copy conf file slave1':
       ensure => directory,
       source => '/vagrant/conf.f/static.conf',
       path => "/etc/nginx/conf.d/",
  }
    service { 'nginx':
    ensure => running,
    enable => true,
  }
}

node 'slave2.puppet' {
  include install_nginx, reload_nginx
}

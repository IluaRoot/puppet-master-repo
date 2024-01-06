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
  include install_nginx
  -> file { 'Copy conf file slave1':
       ensure => file,
       source => '/vagrant/conf.f/static.conf',
       path => "/etc/nginx/conf.d/",
  }
  -> include reload_nginx
}

node 'slave2.puppet' {
  include install_nginx
  -> file { 'Copy conf file slave2':
       ensure => file,
       source => '/vagrant/conf.f/dynamic.conf',
       path => "/etc/nginx/conf.d/",
  }
  -> include reload_nginx
}

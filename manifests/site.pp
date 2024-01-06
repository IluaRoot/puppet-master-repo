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
    -> file { 'Copy conf file slave1':
       ensure => file,
       source => 'puppet:///conf.f/static.conf',
       path => "/etc/nginx/conf.d/",
  }
}

node 'slave2.puppet' {
  include install_nginx, reload_nginx
}

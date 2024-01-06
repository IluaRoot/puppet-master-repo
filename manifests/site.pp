node 'slave1.puppet' {
    package { 'nginx':
    ensure => installed,
    name => 'nginx',
    provider => 'yum',
    }
    -> file { '/vagrant/conf.f/static.con':
       ensure => file,
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

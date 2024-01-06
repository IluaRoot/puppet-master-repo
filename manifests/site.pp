node 'slave1.puppet' {
    package { 'nginx':
    ensure => installed,
    name => 'nginx',
    provider => 'yum',
    }
    -> file { '/vagrant/conf.f/static.conf':
       ensure => 'present',
       source => '/vagrant/conf.f/static.conf',
       path => "/etc/nginx/conf.d/static.conf",
  }
    -> file { '/var/www/static':
       owner => 'nginx',
       group => 'nginx',
       mode => '0755',
       ensure => 'directory',     
    
    }
    -> file { '/vagrant/index.html':
       ensure => 'present',
       source => '/vagrant/index.html',
       path => "/var/www/static/",
  }
    service { 'nginx':
    ensure => running,
    enable => true,
  }
}

node 'slave2.puppet' {
  include install_nginx, reload_nginx
}

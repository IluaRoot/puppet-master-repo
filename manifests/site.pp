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
    include install_nginx }
    file { '/vagrant/conf.f/static.conf':
       ensure => 'present',
       source => '/vagrant/conf.f/static.conf',
       path => "/etc/nginx/conf.d/static.conf",
  }
    -> file { ['/var/www', '/var/www/static']:
       ensure => 'directory',
       owner => 'nginx',
       group => 'nginx',
       mode => '0755',
    }
    
    -> file { '/vagrant/index.html':
       ensure => 'present',
       source => '/vagrant/index.html',
       path => "/var/www/static/index.html",
  }
    service { 'nginx':
    ensure => running,
    enable => true,
  }
}

node 'slave2.puppet' {
  include install_nginx, reload_nginx
}

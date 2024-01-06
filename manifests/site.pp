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
    -> file { '/etc/nginx/nginx.conf':
       ensure => present,
       }
    -> exec { 'Disable default site': 
       command => '/bin/sed -i \'s/listen       80 default_server;/#listen       80 default_server;/\' /etc/nginx/nginx/conf',    
    }
    service { 'nginx':
    ensure => running,
    enable => true,
  }
}

node 'slave2.puppet' {
    package { 'nginx':
    ensure => installed,
    name => 'nginx',
    provider => 'yum',
    }
    package { 'php-fpm':
    ensure => installed,
    name => 'php-fpm',
    provider => 'yum',
    }
}

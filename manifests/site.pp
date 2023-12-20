node default{
  file { '/root/README':
    ensure => file,
    content => 'Hello, world!'
 }
}

node slave1.puppet{
  Package { ensure => 'installed' }
  package { 'screen':}
  package {'vim':}
}

node slave2.puppet{
  file { '/root/personal':
    ensure => file
}

 notify { "Runnong os ${facts['os']['name']} version ${facts['os']['release']['full']}": }
}

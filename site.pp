node default{
  file { '/root/README':
    ensure => file,
    content => 'Hello, world!'
 }
}

node slave1.puppet{

}

node slave2.puppet{
  file { '/root/personal':
    ensure => file
 }
}

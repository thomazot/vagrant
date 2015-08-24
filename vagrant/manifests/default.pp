class base {

  # apt-update
  exec { 'apt-update':
    command => 'apt-get update',
    path    => '/usr/bin'
  }

  package { [
      'vim',
      'git',
      'curl',
      'python-software-properties',
    ]:
    require => Exec['apt-update']
  }

  # Get node
  exec { 'add-node-repo':
    command => '/usr/bin/add-apt-repository ppa:chris-lea/node.js && /usr/bin/apt-get update',
    require => Package['python-software-properties']
  }

  package { 'nodejs':
    require => [Exec['apt-update'], Exec['add-node-repo']],
    ensure => present,
  }

  # Install npm
  exec { 'npm':
      command     => '/usr/bin/curl -L https://npmjs.org/install.sh | /bin/sh',
      require     => [Package['nodejs'], Package['curl']],
      environment => 'clean=yes'
  }

  # install apache2 package
  package { 'apache2':
    require => Exec['apt-update'], 
    ensure => present,
  }

  # ensure apache2 service is running
  service { 'apache2':
    ensure => running,
  }

  # install php5 package
  package { 'php5':
    require => Exec['apt-update'], 
    ensure => present,
  }

  # ensure info.php file exists
  file { '/var/www/index.php':
    ensure => file,
    content => '<?php  phpinfo(); ?>',    # phpinfo code
    require => Package['apache2'],        # require 'apache2' package before creating
  } 

}

include base
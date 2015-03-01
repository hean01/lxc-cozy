class cozy::cozy-monitor {

  exec {'install-cozy-monitor':
    command => 'npm install -g coffee-script cozy-monitor',
    path => ['/bin/', '/usr/bin/'],
    require => Package['npm'],
  }

}

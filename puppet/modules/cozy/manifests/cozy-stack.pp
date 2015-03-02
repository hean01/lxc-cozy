class cozy::cozy-stack {

  exec {'install-stack':
    command => 'cozy-monitor install-cozy-stack',
    path => '/usr/bin',
    require => [ Exec['install-cozy-monitor'], Service['cozy-controller.service'] ],
  }

}

class cozy::cozy-controller {

  exec {'install-cozy-controller':
    command => 'npm install -g cozy-controller',
    path => ['/bin/', '/usr/bin/'],
    require => Package['npm']
  }

  file {'/etc/monit.d/cozy-controller':
    source => 'puppet:///modules/cozy/monit/cozy-controller',
    mode => 600,
    require => Service['cozy-controller.service'],
    notify => Service['monit.service'],
  }

  file {'/usr/lib/systemd/system/cozy-controller.service':
    source => 'puppet:///modules/cozy/systemd/cozy-controller.service',
    mode => 0644,
    require => Exec['install-cozy-controller'],
  }

  service {'cozy-controller.service':
    provider => systemd,
    ensure => running,
    enable => true,
    require => File['/usr/lib/systemd/system/cozy-controller.service'],
  }
}

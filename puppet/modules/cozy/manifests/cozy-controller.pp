class cozy::cozy-controller {

  package {['git', 'sudo', 'patch']:
    ensure => latest,
  }

  exec {'install-cozy-controller':
    command => 'npm install -g cozy-controller',
    path => ['/bin/', '/usr/bin/'],
    require => Package['npm']
  }

  exec {'fix-sudoers':
    command => 'sed -i \'s/Defaults    requiretty/#Defaults    rquiretty/g\' /etc/sudoers',
    path => ['/bin/', '/usr/bin/'],
    before => Service['cozy-controller.service'],
  }

  exec {'apply-patch0':
    command => 'cd / && patch -p0 < /tmp/cozy-controller_fix_env.patch',
    path => ['/bin/', '/usr/bin/'],
    require => [ Package['patch'], File['/tmp/cozy-controller_fix_env.patch'] ],
    before => Service['cozy-controller.service'],
  }

  exec {'apply-patch1':
    command => 'cd / && patch -p0 < /tmp/cozy-controller_fix_adduser_sh.patch',
    path => ['/bin/', '/usr/bin/'],
    require => [ Package['patch'], File['/tmp/cozy-controller_fix_adduser_sh.patch'] ],
    before => Service['cozy-controller.service'],
  }

  file {'/tmp/cozy-controller_fix_env.patch':
    source => 'puppet:///modules/cozy/patches/cozy-controller_fix_env.patch',
  }

  file {'/tmp/cozy-controller_fix_adduser_sh.patch':
    source => 'puppet:///modules/cozy/patches/cozy-controller_fix_adduser_sh.patch',
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

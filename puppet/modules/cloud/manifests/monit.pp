class cloud::monit {

  package {'monit':
    ensure => latest,
    before => File['/etc/monitrc'],
  }

  file {'/etc/monitrc':
    source => 'puppet:///modules/cloud/monit/monitrc',
    mode => 0600,
    before => Service['monit.service'],
  }

  exec {'monit-certificate':
    command => 'openssl req -nodes -x509 -newkey rsa:4096 -keyout /etc/certs/monit.pem -out /etc/certs/monit.pem -days 356 -subj "/CN=lxc.cozy.local"',
    path => ['/bin/','/sbin/'],
    require => [File['/etc/certs'], Package['openssl']],
  }

  file {['/etc/certs/monit.pem', '/etc/certs/monit.crt']:
    mode => 600,
    require => Exec['monit-certificate'],
    before => Service['monit.service'],
  }

  service {"monit.service":
    provider => systemd,
    ensure => running,
    enable => true,
  }
}

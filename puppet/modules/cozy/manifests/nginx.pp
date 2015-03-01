class cozy::nginx {

  package {'nginx':
    ensure => latest,
  }

  file {'/etc/monit.d/nginx':
    source => 'puppet:///modules/cozy/monit/nginx',
    mode => 600,
    require => Service['nginx.service'],
    notify => Service['monit.service'],
  }

  file {'/etc/nginx/conf.d/cozy.conf' :
    source => 'puppet:///modules/cozy/cozy.conf',
    mode => 600,
    notify => Service['nginx.service']
  }

  exec {'cozy-certificate':
    command => 'openssl req -nodes -x509 -newkey rsa:4096 -keyout /etc/cozy/server.key -out /etc/cozy/server.crt -days 356 -subj "/CN=lxc.cozy.local"',
    path => ['/bin/','/sbin/'],
    require => [ File['/etc/cozy'], Package['openssl']],
  }

  file {['/etc/cozy/server.key', '/etc/cozy/server.crt']:
    mode => 600,
    require => Exec['cozy-certificate'],
    before => File['/etc/nginx/conf.d/cozy.conf'],
  }

  service {'nginx.service':
    provider => systemd,
    ensure => running,
    enable => true,
    require => Package['nginx'],
  }
}

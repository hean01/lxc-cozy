class cloud::sshd {

  # monit configuration file for sshd
  file { '/etc/monit.d/sshd':
    source => 'puppet:///modules/cloud/monit/sshd',
    mode => 0600,
    notify => Service['monit.service']
  }

  package {'openssh-server':
    ensure => latest,
    before => File['/etc/monit.d/sshd'],
  }

  service {"sshd.service":
    provider => systemd,
    ensure => running,
    enable => true,
    before => File['/etc/monit.d/sshd'],
  }

}

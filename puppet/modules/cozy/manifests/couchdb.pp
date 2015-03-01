class cozy::couchdb {

  package {'couchdb':
    ensure => latest,
  }

  file {'/etc/cozy/couchdb.login':
    source => 'puppet:///modules/cozy/couchdb.login',
    mode => 600,
    owner => 'cozy-data-system',
    require => [ File['/etc/cozy'], User['cozy-data-system'] ],
  }

  file {'/etc/monit.d/couchdb':
    source => 'puppet:///modules/cozy/monit/couchdb',
    mode => 600,
    require => Service['couchdb.service'],
    notify => Service['monit.service'],
  }

  service {'couchdb.service':
    provider => systemd,
    ensure => running,
    enable => true,
  }
}

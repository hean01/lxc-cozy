class cozy::couchdb {

  package {['couchdb', 'curl']:
    ensure => latest,
  }

  file {'/etc/cozy/couchdb.login':
    source => 'puppet:///modules/cozy/couchdb.login',
    mode => 600,
    owner => 'cozy-data-system',
    require => [ User['cozy-data-system'] ],
  }

  exec {'init-db':,
    command => 'curl -X PUT http://127.0.0.1:5984/_config/admins/cozy -d \'"password"\'',
    path => '/usr/bin',
    require => Package['curl'],
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
    before => Exec['init-db'],
  }
}

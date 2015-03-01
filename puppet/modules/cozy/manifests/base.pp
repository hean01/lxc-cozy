class cozy::base {

  require cloud::monit

  package {['nodejs',
            'npm']:
              ensure => latest,
  }


  file {'/etc/cozy':
    ensure => directory,
    owner => 'cozy',
    group => 'cozy',
    require => [ User['cozy'], Group['cozy'] ],
  }

  file {'/var/run/cozy':
    ensure => directory,
  }

  user {'cozy':
    ensure => present,
  }

  group {'cozy':
    ensure => present,
  }

  user {'cozy-data-system':
    ensure => present,
  }

  include cozy::couchdb
  include cozy::cozy-monitor
  include cozy::cozy-controller
#  include cozy::data-indexer
#  include cozy::data-system
#  include cozy::nginx

}

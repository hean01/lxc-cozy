class cozy::base {

  require cloud::monit

  package {['nodejs',
            'npm']:
              ensure => latest,
  }


  file {'/etc/cozy':
    ensure => directory,
  }

  user {'cozy-data-system':
    ensure => present,
  }

  include cozy::couchdb
#  include cozy::cozy-monitor
#  include cozy::cozy-controller
#  include cozy::data-indexer
#  include cozy::data-system
#  include cozy::nginx

}

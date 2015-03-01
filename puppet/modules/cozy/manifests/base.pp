class cozy::base {

  require cloud::monit

  package {['nodejs',
            'npm']:
              ensure => latest,
  }

#  include cozy::couchdb
#  include cozy::monitor
#  include cozy::controller
#  include cozy::data-indexer
#  include cozy::data-system
#  include cozy::nginx

}

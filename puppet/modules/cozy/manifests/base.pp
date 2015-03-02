class cozy::base {

  package {['nodejs',
            'npm']:
              ensure => latest,
  }

  file {'/etc/cozy':
    ensure => directory,
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

  user {'cozy-home':
    ensure => present,
  }
  group {'cozy-home':
    ensure => present,
  }

  user {'cozy-proxy':
    ensure => present,
  }
  group {'cozy-proxy':
    ensure => present,
  }

  user {'cozy-data-system':
    ensure => present,
  }
  group {'cozy-data-system':
    ensure => present,
  }

  include cozy::couchdb
  include cozy::cozy-monitor
  include cozy::cozy-controller
  include cozy::cozy-stack
  include cozy::nginx

}

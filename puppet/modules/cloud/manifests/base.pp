class cloud::base {

  # Force root password to 'password'
  user {'root':,
    ensure => present,
    password => '$6$2C5HhJVr$lJFQFTIlBpQ/vuJFvJ4o2ooPf.KZRhIEqxgxdC0FIOew/7U55PQ2kd6b2FNO6iFAlOZRLnh6BnsMQyuhIHguG0',
  }
  
  # base packages
  package {['openssl', 'sysstat']:
    ensure => latest
  }

  file {'/etc/certs':
    ensure => directory,
    mode   => 700,
  }

  #
  # Monit
  #
  # Monit is used for all services in software stack that
  # is a part of the cloud instance.
  #
  include cloud::monit

  # ssh service
  include cloud::sshd

  # cozy cloud base installation
  include cozy::base
}

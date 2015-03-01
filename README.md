# CentOS 7 Coxy Cloud LXC

lxc-cozy is a helper suit to build a cozy cloud instance in a linux
container upon a CentOS 7. The project uses mock, lxc to build the
base container which then applies puppet installation of cozy.

  1. Builds couchdb and js185 RPMs for CentOS 7 using mock

  2. Creates a linux container using CentOS 7 minimal installation

  3. Install the local lxc-clozy copy into container for further
     setup

  4. Install of epel-repository so we can install puppet

  5. Install puppet and puppet-firewalld

  6. Runs puppet and applies the cozy cloud instance configuration

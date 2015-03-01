# CentOS 7 Cozy Cloud LXC

lxc-cozy is a helper suit to build a cozy cloud instance in a linux
container upon a CentOS 7 image. The project uses _lxc_ to build the
base container which then applies a puppet installation of cozy.

  1. Creates a linux container using CentOS 7 minimal installation

  2. Install the local lxc-clozy copy into container for further
     setup

  3. Install of epel-repository so we can install puppet

  4. Install puppet and puppet-firewalld

  5. Runs puppet and applies the cozy cloud instance configuration

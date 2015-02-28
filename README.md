# Build current js-devel for CentOS
This repository a fork of http://pkgs.fedoraproject.org/cgit/js.git/

The default spec file in Fedora doesn't provide libjs.so.1 needed for installation in CentOS/RHEL, so I've forked that repository for explicitly building a js185 that provides required dependencies.

## Building on Host OS
* If not already installed, install and configure system for building rpms. [Instructions](http://wiki.centos.org/HowTos/SetupRpmBuildEnvironment)
* Copy contents of this repo to ~/rpmbuild/SOURCES
* Fetch sources
  * spectool -g -R js.spec
* Build SRPM
  * rpmbuild -bs js.spec
* Install dependencies
  * sudo yum-builddep js-1.8.5-15.el6.src.rpm
* Rebuild rpm
  * rpmbuild --rebuild js-1.8.5-15.el6.src.rpm
* Install rpm
  * sudo rpm {-ihv | -U} ~/rpmbuild/RPMS/i386/js-devel-1.8.5-15.el6.i386.rpm

## Building Using Mock
* Install mock
  * [Notes on mock usage](https://fedoraproject.org/wiki/Using_Mock_to_test_package_builds)
* CentOS build
  * copy centos-6-i386.cfg and centos-6-x86_64.cfg to /etc/mock/
* Checkout js sources from Fedora Project
  * git clone https://github.com/wendall911/js185.git
* Fetch sources
  * spectool -g -R -C ./ js.spec
* Build SRPM
  * sudo mock -r epel-6-x86_64 --buildsrpm --sources ./ --spec ./js.spec
* Copy generated SRPM to working directory
  * cp /var/lib/mock/epel-6-x86_64/result/js-1.8.5-15.el6.centos.src.rpm ./
* Install dependencies
  * sudo mock -r epel-6-x86_64 --installdeps js-1.8.5-14.el6.src.rpm
* Build RPM
  * sudo mock -r epel-6-x86_64 rebuild js-1.8.5-14.el6.src.rpm
* Copy built RPMS to working directory
  * cp /var/lib/mock/epel-6-x86_64/result/js-devel-1.8.5-14.el6.x86_64.rpm ./
  * cp /var/lib/mock/epel-6-x86_64/result/js-debuginfo-1.8.5-14.el6.x86_64.rpm ./
  * cp /var/lib/mock/epel-6-x86_64/result/js-1.8.5-14.el6.x86_64.rpm ./
* Install js RPMS into chroot environment
  * sudo mock -r epel-6-x86_64 --install js-1.8.5-14.el6.x86_64.rpm
  * sudo mock -r epel-6-x86_64 --install js-devel-1.8.5-14.el6.x86_64.rpm

## Target Server Installation
* Install js RPM
  * rpm -ihv js-1.8.5-14.el6.x86_64.rpm

.PHONY: external clean
include $(CURDIR)/Makefile.defs
all: lxc-cozy

LXC_RUN := sudo lxc-attach --name $(_LXC_NAME) --

lxc-cozy: clean
	@echo Initialize CentOS 7 LXC container
	sudo lxc-create --name $(_LXC_NAME) --config container.conf --template download -- \
		--dist centos --release 7 --arch amd64
	sudo lxc-start --name $(_LXC_NAME) --daemon
	$(LXC_RUN) dhclient eth0

	@echo Installing lxc-cloud repository into container
	sudo lxc-info --config lxc.rootfs --name cozy | cut -b 14- > $(CURDIR)/rootfs
	sudo cp -r $(CURDIR) $(shell cat ${CURDIR}/rootfs)/opt/lxc-cozy

	@echo Install epel-repostiory and update
	$(LXC_RUN) yum install epel-release --assumeyes
	$(LXC_RUN) yum update --assumeyes

	@echo Install puppet and apply cloud configuration
	$(LXC_RUN) yum install puppet puppet-firewalld --assumeyes
	$(LXC_RUN) puppet apply --modulepath=/opt/lxc-cozy/puppet/modules /opt/lxc-cozy/puppet/manifests/cloud.pp

clean:
	-sudo lxc-stop --name $(_LXC_NAME) --nowait --kill
	-sudo lxc-destroy --name $(_LXC_NAME)

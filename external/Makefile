
all: result/js-1.8.5-15.el7.centos.x86_64.rpm result/couchdb-1.6.1-1.el7.centos.x86_64.rpm

js185/js185-1.0.0.tar.gz:
	spectool -g -R -C $(CURDIR)/js185/ $(CURDIR)/js185/js.spec

result/js-1.8.5-15.el7.centos.src.rpm: js185/js185-1.0.0.tar.gz
	mock -r epel-7-x86_64 --buildsrpm \
		--sources $(CURDIR)/js185/ --spec $(CURDIR)/js185/js.spec \
		--resultdir $(CURDIR)/result

result/js-1.8.5-15.el7.centos.x86_64.rpm: result/js-1.8.5-15.el7.centos.src.rpm
	mock -r epel-7-x86_64 rebuild $(CURDIR)/result/js-1.8.5-15.el7.centos.src.rpm \
		--resultdir $(CURDIR)/result


couchdb/apache-couchdb-1.6.1.tar.gz:
	spectool -g -R -C $(CURDIR)/couchdb/ $(CURDIR)/couchdb/couchdb.spec


result/couchdb-1.6.1-1.el7.centos.src.rpm: couchdb/apache-couchdb-1.6.1.tar.gz
	mock -r epel-7-x86_64 --buildsrpm \
		--sources $(CURDIR)/couchdb/ --spec $(CURDIR)/couchdb/couchdb.spec \
		--resultdir $(CURDIR)/result

result/couchdb-1.6.1-1.el7.centos.x86_64.rpm: result/couchdb-1.6.1-1.el7.centos.src.rpm
	mock -r epel-7-x86_64 rebuild $(CURDIR)/result/couchdb-1.6.1-1.el7.centos.src.rpm \
		--resultdir $(CURDIR)/result

.PHONY: clean
clean:
	$(RM) -rf $(CURDIR)/result

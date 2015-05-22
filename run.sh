#!/bin/bash
set -e
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
/sbin/service elasticsearch start
curl -XPUT -u es_admin:redhat 'http://localhost:9200/_licenses' -d @/etc/elasticsearch/shield/license.json
#tail -f /var/log/elasticsearch/elasticsearch.log
tail -f /dev/null

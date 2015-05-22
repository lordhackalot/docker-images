#!/bin/bash
set -e
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
/sbin/service elasticsearch start
while true; do
 if lsof -ni:9200 ; then
    break;
  else
    echo "watiing.. ";
  fi
  sleep 2
done
curl -XPUT -u es_admin:redhat 'http://localhost:9200/_licenses' -d @/etc/elasticsearch/shield/license.json
#tail -f /var/log/elasticsearch/elasticsearch.log
tail -f /dev/null

#!/bin/bash
set -e
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
echo "${ELASTICNODE}" >  /nodename
sed -i -e 's/\[\[ELASTICNODE\]\]/'"${ELASTICNODE}"'/g' /etc/elasticsearch/elasticsearch.yml
sed -i -e 's/\[\[INST_ADDR\]\]/'"${INST_ADDR}"'/g' /etc/elasticsearch/elasticsearch.yml
sed -i -e 's/\[\[INST_ADDR01\]\]/'"${INST_ADDR01}"'/g' /etc/elasticsearch/elasticsearch.yml
sed -i -e 's/\[\[INST_ADDR02\]\]/'"${INST_ADDR02}"'/g' /etc/elasticsearch/elasticsearch.yml
sed -i -e 's/\[\[INST_ADDR03\]\]/'"${INST_ADDR03}"'/g' /etc/elasticsearch/elasticsearch.yml
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
tail -f /dev/null

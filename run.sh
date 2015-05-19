#!/bin/bash
set -e
export PATH="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
/sbin/service elasticsearch start
#tail -f /var/log/elasticsearch/elasticsearch.log
tail -f /dev/null

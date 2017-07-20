#!/bin/bash

echo "ELASTICSEARCH_URL = $ELASTICSEARCH_URL"
echo "{ELASTICSEARCH_URL} = ${ELASTICSEARCH_URL}"

cat /opt/kibana/config/kibana.yml

if [[ -n "$ELASTICSEARCH_URL" ]]; then
  sed -i 's|^\(# \+\)\?elasticsearch\.url:.*$|elasticsearch.url: '"\"$ELASTICSEARCH_URL\""'|' /opt/kibana/config/kibana.yml
elif [[ -n "$ELASTICSEARCH_SERVICE_NAME" ]]; then
    SVC_HOST=${ELASTICSEARCH_SERVICE_NAME}_SERVICE_HOST
    SVC_PORT=${ELASTICSEARCH_SERVICE_NAME}_SERVICE_PORT
    sed -i 's|^\(# \+\)\?elasticsearch\.url:.*$|elasticsearch.url: '"\"http://${!SVC_HOST}:${!SVC_PORT}\""'|' /opt/kibana/config/kibana.yml
fi

cat /opt/kibana/config/kibana.yml

exec /opt/kibana/bin/kibana

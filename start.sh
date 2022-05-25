#!/bin/bash

DIR=`pwd`
echo "Getting Elasticsearch port..."
ES_PORT=`bash getElasticsearchPort.sh`
echo $ES_PORT
cd localEnv/current/kibana*
echo "Starting Kibana... (reload the browser tab if necessary)"
open "http://localhost:5601/app/dev_tools#/console"
bin/kibana -e 'http://localhost:'${ES_PORT}
cd $DIR
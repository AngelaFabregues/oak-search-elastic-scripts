#!/bin/bash
echo "Killing Kibana..."
kill $(lsof -t -i:5601)
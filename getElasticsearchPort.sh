#!/bin/bash
PORT=`docker container list | grep elasticsearch | awk '{ print $12 }' | sed 's/->9200\/tcp,//g' | sed 's/0.0.0.0://g'`
echo $PORT
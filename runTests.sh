#!/bin/bash
DIR=`pwd`
cd ../angela-jackrabbit-oak/oak-search-elastic/src/test/java/org/apache/jackrabbit/oak/plugins/index/elastic/

TESTS=`find . | grep java$ | sed 's/^.\/index\///g' | sed 's/^.\/query\///g' | sed 's/^.\///g' | sed 's/.java$//g'`

cd $DIR
cd ../angela-jackrabbit-oak/oak-search-elastic

mvn install -Dmaven.test.skip > $DIR/tests.out

COUNT=0
TESTLIST=""
for TEST in $TESTS
do
   : 
   TESTLIST=$TESTLIST$TEST
   COUNT=$[$COUNT+1]
   MOD=$[$COUNT % 5]
   if [ $MOD -eq 0 ]; then
   	mvn -Dtest=$TESTLIST test >> $DIR/tests.out
   	TESTLIST=""
   else
   	TESTLIST=$TESTLIST","
   fi
done
mvn -Dtest=$TESTLIST test >> $DIR/tests.out
cat $DIR/tests.out | grep "Tests run" | grep ERROR
cd $DIR
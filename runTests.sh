#!/bin/bash
SECONDS=0
DIR=`pwd`
LOCAL_REPO=angela-jackrabbit-oak

if [ $# -gt 0 ]; then
   LOCAL_REPO=angela-jackrabbit-oak-deploy
fi
echo "Using $LOCAL_REPO"

cd ../${LOCAL_REPO}/oak-search-elastic/src/test/java/org/apache/jackrabbit/oak/plugins/index/elastic/

TESTS=`find . | grep java$ | sed 's/^.\/index\///g' | sed 's/^.\/query\///g' | sed 's/^.\///g' | sed 's/.java$//g'`

cd $DIR
cd ../${LOCAL_REPO}/oak-search-elastic

mvn clean install -Dmaven.test.skip > $DIR/tests.out

echo "Compiled"

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

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
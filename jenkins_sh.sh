#!/bin/sh

JENKINSCLI=jenkins-cli.jar

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <endpoint> <cmd>"
  exit 1
fi

ENDPOINT=$1
CMD=$2

CMD=`echo $CMD | perl -ne'split /\s+/;$cmd=join ",", map{qq/"$_"/}@_;print "[$cmd]"' `

if [ ! -f $JENKINSCLI ]; then
  echo "Could not find $JENKINSCLI"
  exit 1
fi

java -jar $JENKINSCLI -s $ENDPOINT groovysh "proc = $CMD.execute();proc.waitFor();println proc.in.text"

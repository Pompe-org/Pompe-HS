#!/bin/bash
base_dir="${POMPE_HOME}/experiments/pompe/"

if [ "$#" -le 1 ]
then

  echo "Usage: collect_data.sh {username} {local or distributed}"

else


rm -f $base_dir/data/* 2> /dev/null

cat $base_dir/conf-$2/client.hosts | while read machine
do

  scp $1@${machine}:$base_dir/log/client* $base_dir/data/;

done

fi

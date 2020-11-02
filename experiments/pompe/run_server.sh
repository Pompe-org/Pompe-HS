#!/bin/bash
base_dir="${POMPE_HOME}/experiments/pompe/"

if [ "$#" -le 1 ]
then

  echo "Usage: run_server.sh {username} {local or distributed}"

else

    replica_id=0
    cat $base_dir/conf-$2/server.hosts | while read machine
    do
        echo "#### deploy replica ${replica_id} on machine ${machine}"

        ssh $1@${machine} "export POMPE_HOME=${POMPE_HOME}; ${base_dir}/single_server.sh ${replica_id} $2 &" &

        replica_id=$((replica_id+1))
    done

fi

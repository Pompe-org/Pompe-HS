#!/bin/bash

base_dir="${POMPE_HOME}/experiments/pompe/"

if [ "$#" -le 1 ]
then

    echo "Usage: single_client.sh {client ID} {local or distributed}"

else

echo "    starting archipelago replica $1"

${POMPE_HOME}/libhotstuff/examples/pompe-app $base_dir/conf-$2/hotstuff.gen.conf $base_dir/log/server$1.log --conf $base_dir/conf-$2/hotstuff.gen-sec$1.conf> /dev/null   2>&1 &

fi

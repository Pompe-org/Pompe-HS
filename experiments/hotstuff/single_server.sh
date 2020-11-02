#!/bin/bash
base_dir="${POMPE_HOME}/experiments/hotstuff/"


if [ "$#" -le 1 ]
then

    echo "Usage: single_server.sh {replica ID} {local or distributed}"

else

# original hotstuff only one instance
echo "    starting baseline replica $1"

${POMPE_HOME}/libhotstuff/examples/hotstuff-app $base_dir/conf-$2/hotstuff.gen.conf --conf $base_dir/conf-$2/hotstuff.gen-sec$1.conf > /dev/null 2>&1 &

fi

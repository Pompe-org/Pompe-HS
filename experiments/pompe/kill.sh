#!/bin/bash
base_dir="${POMPE_HOME}/experiments/pompe/"

if [ "$#" -le 1 ]
then

    echo "Usage: kill.sh {username} {local or distributed}"

else

# kill the clients first
cat $base_dir/conf-$2/client.hosts | while read machine
do
    echo "kill clients on machine ${machine}"
    ssh $1@${machine} "killall pompe-client 2> /dev/null" &
done

# then kill the servers
cat $base_dir/conf-$2/server.hosts | while read machine
do
    echo "kill servers on machine ${machine}"
    ssh $1@${machine} "killall pompe-app 2> /dev/null" &
done

fi

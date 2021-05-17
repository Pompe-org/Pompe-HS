if [ "$#" -le 0 ]
then

    echo "Usage: deploy.sh {username}"

else
    # remove old log and data
    rm ./deploy/*/log/*
    rm ./deploy/*/data/*
    
    cat all.hosts | while read machine
    do
        echo "deploy code on machine ${machine} at ${POMPE_HOME}"

        rsync -rtuv ./libhotstuff/examples $1@${machine}:${POMPE_HOME}/libhotstuff/ 

	    rsync -rtuv ./libhotstuff/deploy $1@${machine}:${POMPE_HOME}/libhotstuff/

    done

fi

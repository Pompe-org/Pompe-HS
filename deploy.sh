if [ "$#" -le 0 ]
then

    echo "Usage: deploy.sh {username}"

else
    # remove old log and data
    rm ./experiments/*/log/*.log
    rm ./experiments/*/data/*.log
    
    cat all.hosts | while read machine
    do
        echo "deploy code on machine ${machine} at ${POMPE_HOME}"

	# Pompe binary executable
        rsync -rtuv ./libhotstuff/examples $1@${machine}:${POMPE_HOME}/libhotstuff/ --exclude CMakeFiles
	# Pompe configuration files
        rsync -rtuv ./experiments $1@${machine}:${POMPE_HOME}/
	# Pompe dependency installation
	scp ./install_deps.sh $1@${machine}:${POMPE_HOME}/

    done

fi

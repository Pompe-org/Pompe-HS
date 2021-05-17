# Pompe-Hotstuff

This repo contains our implementation of Pompe on top of HotStuff. Please refer to our OSDI'20 paper and contact Yunhao Zhang(yz2327@cornell.edu) for questions about this repo.

## Table of Contents

* Build and Run
* Validate the Claims in Evaluation
* Troubleshooting


### Build and run on local machine

We assume that you use a Linux machine, your username is `user1` and the machine name is `driver`, so the `user1@driver:` below indicates your shell prompt. 


```shell
# Feel free to change the /home/yunhao below to any other directory
user1@driver: export POMPE_HOME=/home/yunhao/Pompe-HS
user1@driver: cd /home/yunhao/
user1@driver: git clone --recursive git@github.com:Pompe-org/Pompe-HS.git

# Install dependencies
user1@driver: cd $POMPE_HOME
user1@driver: ./install_deps.sh

# Build Pompe
user1@driver: cd $POMPE_HOME/libhotstuff
user1@driver: ./build.sh

# Run 4 Pompe servers
user1@driver: cd $POMPE_HOME/experiments/pompe
user1@driver: ./run_server.sh yunhao local

# Run 4 Pompe clients for a 30 second experiment
user1@driver: cd $POMPE_HOME/experiments/pompe
user1@driver: ./run_client.sh yunhao 4 30 local

# Kill the Pompe servers and clients
user1@driver: ./kill.sh yunhao local
```
> :warning: **[WARNING]** Revision in progress, expected to finish revision soon.

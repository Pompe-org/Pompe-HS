# Pompe-Hotstuff

This repo contains our implementation of Pompe on top of HotStuff. Please refer to our [OSDI'20 paper](https://www.usenix.org/conference/osdi20/presentation/zhang-yunhao) and contact Yunhao Zhang (yz2327@cornell.edu) for any questions.


## Build and Run
### Build and run on local machine

My Linux username is `yunhao` and machine name is `driver`, so the `yunhao@driver:` below indicates my shell prompt. 
Replace the `yunhao` and `driver` below with your own username and machine name.


```shell
# Feel free to change the /home/yunhao below to any other directory
yunhao@driver: export POMPE_HOME=/home/yunhao/Pompe-HS
yunhao@driver: cd /home/yunhao/
yunhao@driver: git clone --recursive git@github.com:Pompe-org/Pompe-HS.git

# Install dependencies
yunhao@driver: cd $POMPE_HOME
yunhao@driver: ./install_deps.sh

# Build Pompe
yunhao@driver: cd $POMPE_HOME/libhotstuff
yunhao@driver: ./build.sh

# Run 4 Pompe servers
yunhao@driver: cd $POMPE_HOME/experiments/pompe
yunhao@driver: ./run_server.sh yunhao local

# Run 4 Pompe clients for a 30 second experiment
yunhao@driver: cd $POMPE_HOME/experiments/pompe
yunhao@driver: ./run_client.sh yunhao 4 30 local
# output will look like:
...
client write to order log file /home/yunhao/Pompe-HS/experiments/pompe//log/client0.order.log, 58342 entries
client write to exec log file /home/yunhao/Pompe-HS/experiments/pompe//log/client0.exec.log, 57233 entries
# which means that, in 30 seconds, the client has processed 
# the ordering phase of 58342 commands
# and the consensus phase of 57233 commands
```

### Generate configurations for distributed cluster

The Python script `$POMPE_HOME/libhotstuff/scripts/gen_conf.py` generates the configuration files. First, modify the IP addresses of the server nodes according to your experiment environment.

```python
    # in hotstuff/scripts/gen_conf.py
    ...
        # datacenter small
        ips = ['10.0.0.4', '10.0.0.5', '10.0.0.6', '10.0.0.7']
        # modify this ips variable to your own server list
    ...
```

Then generate your configuration files and replace the old ones.

```shell
yunhao@driver: cd $POMPE_HOME/libhotstuff
yunhao@driver: python scripts/gen_conf.py
yunhao@driver: cp ./conf-gen/* $POMPE_HOME/experiments/pompe/conf-distributed/

# update the client and server IP/hostname
yunhao@driver: vim $POMPE_HOME/experiments/pompe/conf-distributed/client.hosts
yunhao@driver: vim $POMPE_HOME/experiments/pompe/conf-distributed/server.hosts

# put all client and server IP/hostname into the file below
yunhao@driver: vim $POMPE_HOME/all.hosts
```

Now you are ready to run Pompe in a distributed cluster.

### Build and run on distributed cluster

First, you need to install dependencies on all machines in the cluster.


```shell
# run install_deps.sh on all machines in the cluster
yunhao@{machine_name}: export POMPE_HOME=/home/yunhao/Pompe-HS
yunhao@{machine_name}: $POMPE_HOME/install_deps.sh
```

Then, you can deploy and run distributed experiments from your driver machine.
We assume that Pompe has been built successfully on the driver machine.
Make sure that driver can ssh directly to all machines in the cluster (see ssh-copy-id).

```shell
# Deploy Pompe to all.hosts
yunhao@driver: cd $POMPE_HOME
yunhao@driver: ./deploy.sh yunhao

# Run Pompe servers
yunhao@driver: cd $POMPE_HOME/experiments/pompe
yunhao@driver: ./run_server.sh yunhao distributed

# Run 4 Pompe clients for a 30 second experiment
yunhao@driver: cd $POMPE_HOME/experiments/pompe
yunhao@driver: ./run_client.sh yunhao 4 30 distributed

# Collect the experiment data
yunhao@driver: cd $POMPE_HOME/experiments/pompe
yunhao@driver: ./data.sh yunhao distributed

# Show aggregated results
yunhao@driver: cd $POMPE_HOME/experiments
yunhao@driver: python process.py order pompe/data
yunhao@driver: python process.py exec pompe/data
```

## Evaluation and Troubleshooting

The file [Evaluation.md](https://github.com/Pompe-org/Pompe-HS/blob/master/Evaluation.md) in this repo describes how to validate the 4 evaluation claims in our OSDI paper as well as fixes to common issues.

# Pompe-Hotstuff Evaluation

This document describes how to validate the evaluation claims in our [OSDI'20 paper](https://www.usenix.org/conference/osdi20/presentation/zhang-yunhao). Please contact Yunhao Zhang (yz2327@cornell.edu) for questions.

## Validate the Claims

We made 3 claims as shown in Figure3 of our paper.

- **claim1**: Pompe incurs higher latency than its baselines, but by batching in both phases, Pompe achieves higher throughput at competative latencies.

- **claim2**: Pompe's throughput degrades when *n* increases, but Pompe can scale-up each node for higher throughput.

- **claim3**: Pompe incurs modest network overheads over its baselines.



> :warning: **[WARNING]** Revision in progress, expected to finish soon. The old version for artifact evaluation is [here](https://github.com/yhzhang0128/archipelago-hotstuff)

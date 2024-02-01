#!/bin/bash

# DSE Cassandra Anti-Entropy (AE) Stage Alert Script

# Variables
topic_arn="arn:aws:sns:us-east-1:000000000000:abc-prd-cassandra-sns"
env="PRD"
host=$(hostname -s)
threshold=5 # Set the threshold for Anti-Entropy stage pending tasks

date

# Check Anti-Entropy stage pending tasks
ae_pending_tasks=$(nodetool tpstats | grep "AntiEntropySessions" | awk '{print $11}')

if [ -z "$ae_pending_tasks" ]; then
    ae_pending_tasks=0
fi

if [ "$ae_pending_tasks" -ge "$threshold" ]; then
    echo -e "Cassandra Cluster is experiencing high Anti-Entropy stage pending tasks: ${ae_pending_tasks}\n" > nodetool_tpstats_ae.txt
    date >> nodetool_tpstats_ae.txt
    nodetool tpstats >> nodetool_tpstats_ae.txt
    aws sns publish --topic-arn $topic_arn --subject "ABC $env Cassandra Write Latency Alert $host" --message file://nodetool_tpstats_ae.txt
fi

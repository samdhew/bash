#!/bin/bash

# DSE Cassandra Pending Repairs Alert Script

# Variables
topic_arn="arn:aws:sns:us-east-1:000000000000:abc-prd-cassandra-sns"
env="PRD"
host=$(hostname -s)

date

# Check if there are pending repairs
pending_repairs=$(nodetool repair -pr | grep "Repair" | grep -E "not|awaiting" | wc -l)

if [ "$pending_repairs" -gt 0 ]; then
    echo -e "Cassandra Cluster has pending repairs: ${pending_repairs}\n" > nodetool_repairs.txt
    date >> nodetool_repairs.txt
    nodetool tpstats >> nodetool_repairs.txt
    aws sns publish --topic-arn $topic_arn --subject "ABC $env Cassandra Write Latency Alert $host" --message file://nodetool_repairs.txt
fi

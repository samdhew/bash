#!/bin/bash

# DSE Cassandra Read Latency Alert Script

# Variables
topic_arn="arn:aws:sns:us-east-1:000000000000:abc-prd-cassandra-sns"
env="PRD"
host=$(hostname -s)
threshold=10 # Set the threshold for read latency (in milliseconds)

date

# Check read latency using nodetool
read_latency=$(nodetool tpstats | grep "ReadStage" | awk '{print $13}')

if [ -z "$read_latency" ]; then
    read_latency=0
fi

if [ "$read_latency" -ge "$threshold" ]; then
    echo -e "Cassandra Cluster is experiencing high read latency: ${read_latency} ms\n" > nodetool_tpstats_read.txt
    date >> nodetool_tpstats_read.txt
    nodetool tpstats >> nodetool_tpstats_read.txt
    aws sns publish --topic-arn $topic_arn --subject "ABC $env Cassandra Read Latency Alert $host" --message file://nodetool_tpstats_read.txt
fi

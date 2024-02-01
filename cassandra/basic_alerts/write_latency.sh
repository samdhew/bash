#!/bin/bash

# DSE Cassandra Write Latency Alert Script

# Variables
topic_arn="arn:aws:sns:us-east-1:000000000000:abc-prd-cassandra-sns"
env="PRD"
host=$(hostname -s)
threshold=10 # Set the threshold for write latency (in milliseconds)

date

# Check write latency using nodetool
write_latency=$(nodetool tpstats | grep "MutationStage" | awk '{print $13}')

if [ -z "$write_latency" ]; then
    write_latency=0
fi

if [ "$write_latency" -ge "$threshold" ]; then
    echo -e "Cassandra Cluster is experiencing high write latency: ${write_latency} ms\n" > nodetool_tpstats_write.txt
    date >> nodetool_tpstats_write.txt
    nodetool tpstats >> nodetool_tpstats_write.txt
    aws sns publish --topic-arn $topic_arn --subject "ABC $env Cassandra Write Latency Alert $host" --message file://nodetool_tpstats_write.txt
fi

#!/bin/bash

date

# DSE Cassandra Health Check Script

# Variables
topic_arn="arn:aws:sns:us-east-1:000000000000:abc-prd-cassandra-sns"
env="PRD"
host=$(hostname -s)

# Check if all nodes are up
nodetool status | grep "UN" || {
    echo -e "Cassandra Cluster is not healthy. Nodes are down.\n" > nodetool_status.txt
    date >> nodetool_status.txt
    nodetool status >> nodetool_status.txt
    aws sns publish --topic-arn $topic_arn --subject "ABC $env Cassandra Health Alert $host" --message file://nodetool_status.txt
    exit 1
}

# Check if compactions are running
nodetool compactionstats | grep -E "pending tasks:|completed tasks:|active compactions:|compaction type:" || {
    echo -e "Cassandra Cluster is not healthy. Compaction issues detected.\n" > nodetool_compactionstats.txt
    date >> nodetool_compactionstats.txt
    nodetool compactionstats >> nodetool_compactionstats.txt
    aws sns publish --topic-arn $topic_arn --subject "ABC $env Cassandra Health Alert $host" --message file://nodetool_compactionstats.txt
    exit 1
}

# Check read and write latencies
nodetool tpstats | grep "ReadStage\|WriteStage" || {
    echo -e "Cassandra Cluster is not healthy. Read/Write latencies are not normal.\n" > nodetool_tpstats.txt
    date >> nodetool_tpstats.txt
    nodetool tpstats >> nodetool_tpstats.txt
    aws sns publish --topic-arn $topic_arn --subject "ABC $env Cassandra Health Alert $host" --message file://nodetool_tpstats.txt
    exit 1
}

# Additional checks can be added based on specific criteria

# If everything is fine, exit with success status
exit 0

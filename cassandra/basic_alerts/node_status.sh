#!/bin/bash

# DSE Cassandra Node Status Alert Script

# Variables
topic_arn="arn:aws:sns:us-east-1:000000000000:abc-prd-cassandra-sns"
env="PRD"
host=$(hostname -s)

date

# Check if any nodes are down
nodetool_status=$(nodetool status | grep "UN")

if [ -z "$nodetool_status" ]; then
    echo -e "Cassandra Cluster is not healthy. Nodes are down.\n" > nodetool_status.txt
    date >> nodetool_status.txt
    nodetool status >> nodetool_status.txt
    aws sns publish --topic-arn $topic_arn --subject "ABC $env Cassandra Node Alert $host" --message file://nodetool_status.txt
fi

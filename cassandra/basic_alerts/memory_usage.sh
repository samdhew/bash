#!/bin/bash

# DSE Cassandra Memory Usage Alert Script

# Variables
topic_arn="arn:aws:sns:us-east-1:000000000000:abc-prd-cassandra-sns"
env="PRD"
host=$(hostname -s)
threshold=70 # Set the threshold for memory usage (percentage)

date

# Check memory usage
memory_usage=$(free | awk '/Mem/ {print $3/$2 * 100.0}')

if [ -z "$memory_usage" ]; then
    memory_usage=0
fi

if [ "$memory_usage" -ge "$threshold" ]; then
    echo -e "Cassandra Cluster is not healthy. Node's memory usage is above the threshold: ${memory_usage}%\n" > node_memory_usage.txt
    date >> node_memory_usage.txt
    free >> node_memory_usage.txt
    aws sns publish --topic-arn $topic_arn --subject "ABC $env Cassandra Node's Memory Usage Alert $host" --message file://node_memory_usage.txt
fi

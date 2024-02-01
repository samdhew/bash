#!/bin/bash

# DSE Cassandra Disk Usage Alert Script

# Variables
topic_arn="arn:aws:sns:us-east-1:000000000000:abc-prd-cassandra-sns"
env="PRD"
host=$(hostname -s)
threshold=60 # Set the threshold for disk usage (percentage)

date

# Check disk usage
disk_usage=$(df -h | grep "/dev/sd" | awk '{print $5}' | sed 's/%//')

if [ -z "$disk_usage" ]; then
    disk_usage=0
fi

if [ "$disk_usage" -ge "$threshold" ]; then
    echo -e "Cassandra Cluster is not healthy. Node's disk usage is above the threshold: ${disk_usage}%\n" > node_disk_usage.txt
    date >> node_disk_usage.txt
    free >> node_disk_usage.txt
    aws sns publish --topic-arn $topic_arn --subject "ABC $env Cassandra Node's Disk Usage Alert $host" --message file://node_disk_usage.txt
fi

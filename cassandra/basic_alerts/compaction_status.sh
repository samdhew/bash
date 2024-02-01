#!/bin/bash

# DSE Cassandra Compaction Issues Alert Script

# Variables
topic_arn="arn:aws:sns:us-east-1:000000000000:abc-prd-cassandra-sns"
env="PRD"
host=$(hostname -s)

date

# Check if compactions are running
compaction_status=$(nodetool compactionstats | grep -E "pending tasks:|completed tasks:|active compactions:|compaction type:")

if [ -z "$compaction_status" ]; then
    echo -e "Cassandra Cluster is not healthy. Compaction issues detected.\n" > nodetool_compactionstats.txt
    date >> nodetool_compactionstats.txt
    nodetool compactionstats >> nodetool_compactionstats.txt
    aws sns publish --topic-arn $topic_arn --subject "ABC $env Cassandra Compaction Alert $host" --message file://nodetool_compactionstats.txt
fi

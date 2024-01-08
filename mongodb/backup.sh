#! /bin/bash

# Specify the base directory for MongoDB backups
BASE_A="/data/backups/<a_database_name>/"

# Create a directory with the current date for the backup
mkdir -p "$BASE_A/$(date '+%d%m%Y')"

# Change to the newly created backup directory
cd "$BASE_A/$(date '+%d%m%Y')"

# Run mongodump to create a MongoDB backup
/usr/bin/mongodump --host=<hostname> --port=27017 --username=backup_user --password=password1 --authenticationDatabase=admin --db=<a_database_name> --excludeCollection=<a_collection_name> --dumpDbUsersAndRoles

# Compress the backup directory using tar
tar -czvf "dump_$(date '+%d%m%Y').tar.gz" dump

# Copy the compressed backup to Amazon S3
aws s3 cp "dump_$(date '+%d%m%Y').tar.gz" "s3://<aws_s3_bucket>/<a_database_name>/"

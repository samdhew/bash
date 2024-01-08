#! /bin/bash

# Specify the base directory for MongoDB backups
BASE_A="/data/backups/<a_database_name>/"

# Create a directory with the current date for the restored backup
mkdir -p "$BASE_A/$(date '+%d%m%Y')"

# Change to the newly created restored backup directory
cd "$BASE_A/$(date '+%d%m%Y')"

# Download MongoDB backup from Amazon S3
aws s3 cp "s3://<aws_s3_bucket>/<a_database_name>/dump_$(date '+%d%m%Y').tar.gz" .

# Extract the backup using tar
tar -xzvf "dump_$(date '+%d%m%Y').tar.gz"

# Uncomment and customize the following line based on your needs
# /usr/bin/mongorestore --host=<hostname> --port=27017 --username=backup_user --password=password1 --ssl --sslCAFile=/root/global-bundle.pem --sslAllowInvalidHostnames --authenticationDatabase=admin --numInsertionWorkersPerCollection=6 --nsFrom='<aaa_database_name>.*' --nsTo='<a_database_name>.*' dump

# Restore the MongoDB backup using mongorestore
/usr/bin/mongorestore --host=<hostname> --port=27017 --username=backup_user --password=password1 --ssl --sslCAFile=/root/global-bundle.pem --sslAllowInvalidHostnames --authenticationDatabase=admin dump

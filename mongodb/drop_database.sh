#! /bin/bash

# MongoDB database to drop
database_name="<a_database_name>"

# Use mongosh to drop the MongoDB database
echo "db.dropDatabase()" | \
    mongosh --host <hostname> --port 27017 --username admin --password yOucaNsEeME --tls --tlsCAFile /root/global-bundle.pem --tlsAllowInvalidHostnames $database_name

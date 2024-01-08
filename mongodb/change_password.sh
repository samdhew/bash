#! /bin/bash

# MongoDB user details
appuser="a_appuser"

# Set the new password for the MongoDB user
new_password='yOucaNTsEeME'

# Use mongosh to change the user password
echo "db.changeUserPassword('$appuser', '$new_password')" | \
    mongosh --host <hostname> --port 27017 --username admin --password yOucaNsEeME --tls --tlsCAFile /root/global-bundle.pem --tlsAllowInvalidHostnames admin

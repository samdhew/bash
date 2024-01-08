# MongoDB Operations Scripts

This repository contains a set of Bash scripts designed for various MongoDB database operations. The scripts are created to facilitate tasks such as changing user passwords, dropping databases, creating backups, and restoring data. Below are details about each script:

## 1. `change_password.sh`

This script changes the password for a MongoDB user using `mongosh`. It sets the new password for the specified MongoDB user and connects to the server to apply the change.

### Usage:
```bash
./change_password.sh
```
**Instructions:**
- Update the appuser and new_password variables with the MongoDB user and the new password, respectively.
- Replace <hostname> with the actual MongoDB server hostname or IP address.

## 2. `drop_database.sh`

This script drops a MongoDB database using `mongosh`. It deletes the specified database, and caution should be exercised before executing this script as it irreversibly removes data.

### Usage:
```bash
./drop_database.sh
```
**Instructions:**
- Replace `<a_database_name>` and `<hostname>` with the MongoDB database name and server hostname, respectively.
- Update the `admin_password` variable with the MongoDB admin user's password.

## 3. `backup_database.sh`

This script creates a backup of a MongoDB database using `mongodump` and uploads it to Amazon S3. It creates a timestamped directory for the backup, compresses it with tar, and then copies it to an Amazon S3 bucket.

### Usage:
```bash
./backup_database.sh
```
**Instructions:**
- Replace `<a_database_name>`, `<a_collection_name>`, `<hostname>` and `<aws_s3_bucket>` with your specific MongoDB and Amazon S3 details.
- Update the `backup_user` and `password1` variables with appropriate credentials.

## 4. `restore_database.sh`

This script restores a MongoDB database from a backup stored on Amazon S3. It downloads the backup, extracts it, and then uses `mongorestore` to restore the data.

### Usage:
```bash
./restore_database.sh
```
**Instructions:**
- Replace `<a_database_name>`, `<a_collection_name>`, `<hostname>` and `<aws_s3_bucket>` with your specific MongoDB and Amazon S3 details.
- Update the `backup_user` and `password1` variables with appropriate credentials.

These scripts provide a set of tools for managing MongoDB databases, offering flexibility and convenience for routine tasks. Always review and customize the scripts based on your specific requirements before execution.

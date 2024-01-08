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

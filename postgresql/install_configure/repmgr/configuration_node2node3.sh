# Switch to PostgreSQL user
su - postgresql
 
# Show the current status of the REPMGR cluster on node02
/usr/pgsql-13/bin/repmgr -h node02 -U repmgr -d repmgr -f /etc/repmgr/13/repmgr.conf cluster show
 
# Start the REPMGR daemon in dry-run mode (no actual start)
/usr/pgsql-13/bin/repmgr -f /etc/repmgr/13/repmgr.conf daemon start --dry-run
 
# Perform a dry-run of cloning the standby node01
/usr/pgsql-13/bin/repmgr -h node01 -U repmgr -d repmgr -f /etc/repmgr/13/repmgr.conf standby clone -F --dry-run
 
# Clone the standby node01 using the REPMGR command
/usr/pgsql-13/bin/repmgr -h node01 -U repmgr -d repmgr -f /etc/repmgr/13/repmgr.conf standby clone -F
 
# Edit the pg_hba.conf file to configure access for the standby node
vi /DATA/postgresql/13/data/pg_hba.conf
 
# Perform a dry-run of registering the standby node
/usr/pgsql-13/bin/repmgr -f /etc/repmgr/13/repmgr.conf standby register --dry-run
 
# Register the standby node using the REPMGR command
/usr/pgsql-13/bin/repmgr -f /etc/repmgr/13/repmgr.conf standby register
 
# Show the current status of the REPMGR cluster on node02
/usr/pgsql-13/bin/repmgr -h node02 -U repmgr -d repmgr -f /etc/repmgr/13/repmgr.conf cluster show
 
# Check the status of the standby node02
/usr/pgsql-13/bin/repmgr -h node02 -U repmgr -d repmgr -f /etc/repmgr/13/repmgr.conf node check
 
# Display the detailed status of the standby node02
/usr/pgsql-13/bin/repmgr -h node02 -U repmgr -d repmgr -f /etc/repmgr/13/repmgr.conf node status
 
# Monitor PostgreSQL logs in real-time for any changes
tail -f /DATA/postgresql/13/data/log/postgresql-Mon.log  # Mon, Tue, Wed, Thu, Fri, Sat, Sun

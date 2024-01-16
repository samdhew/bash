# Switch to PostgreSQL user
su - postgresql
 
# Show the current status of the REPMGR cluster on node01
/usr/pgsql-13/bin/repmgr -h node01 -U repmgr -d repmgr -f /etc/repmgr/13/repmgr.conf cluster show
 
# Check the status of the node01 in the REPMGR cluster
/usr/pgsql-13/bin/repmgr -h node01 -U repmgr -d repmgr -f /etc/repmgr/13/repmgr.conf node check
 
# Display the current status of all nodes in the REPMGR cluster
/usr/pgsql-13/bin/repmgr -h node01 -U repmgr -d repmgr -f /etc/repmgr/13/repmgr.conf node status
 
# Perform a dry-run of registering node01 as the primary
/usr/pgsql-13/bin/repmgr -f /etc/repmgr/13/repmgr.conf primary register --dry-run
 
# Register node01 as the primary in the REPMGR cluster
/usr/pgsql-13/bin/repmgr -f /etc/repmgr/13/repmgr.conf primary register
 
# Start the REPMGR daemon on node01 (dry-run, no actual start)
/usr/pgsql-13/bin/repmgr -f /etc/repmgr/13/repmgr.conf daemon start --dry-run
 
# Show the updated status of the REPMGR cluster on node01
/usr/pgsql-13/bin/repmgr -h node01 -U repmgr -d repmgr -f /etc/repmgr/13/repmgr.conf cluster show
 
# Check the status of node01 in the REPMGR cluster
/usr/pgsql-13/bin/repmgr -h node01 -U repmgr -d repmgr -f /etc/repmgr/13/repmgr.conf node check
 
# Display the current status of all nodes in the REPMGR cluster
/usr/pgsql-13/bin/repmgr -h node01 -U repmgr -d repmgr -f /etc/repmgr/13/repmgr.conf node status
 
# Copy the REPMGR configuration file to other nodes (node02 and node03)
scp /export/home/postgres1/repmgr.conf postgres1@node02:repmgr.conf
scp /export/home/postgres1/repmgr.conf postgres1@node03:repmgr.conf

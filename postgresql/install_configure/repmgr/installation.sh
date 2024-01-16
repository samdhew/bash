# Switch to superuser
sudo su -
 
# Install REPMGR package for PostgreSQL 13
yum install -y repmgr13
 
# Create a backup of the REPMGR configuration file
cp /etc/repmgr/13/repmgr.conf /etc/repmgr/13/repmgr.conf.bk
 
# Edit the REPMGR configuration file with specific settings
vi /etc/repmgr/13/repmgr.conf
 
# Edit the PostgreSQL server configuration file
vi /DATA/postgresql/13/data/postgresql.conf
 
# Edit the PostgreSQL server pg_hba.conf file for host-based authentication
vi /DATA/postgresql/13/data/pg_hba.conf
 
# Edit the REPMGR systemd service file for PostgreSQL 13
vi /usr/lib/systemd/system/repmgr-13.service
 
# Edit the logrotate configuration file for REPMGR logs
vi /etc/logrotate.conf
 
# Create a log file for REPMGR and set appropriate ownership
touch /var/log/repmgr/repmgr.log
chown -R postgres1:postgres1 /var/log/repmgr
 
# Reload systemd configuration after editing service files
systemctl daemon-reload
 
# Restart PostgreSQL 13 and REPMGR services
systemctl restart postgresql-13
 
# Monitor PostgreSQL logs for status and replication information
tail -f /DATA/postgresql/13/data/log/postgresql-Mon.log  # Mon,Tue,Wed,Thu,Fri,Sat,Sun
 
# Copy the updated REPMGR configuration file to user's home directory
cp /etc/repmgr/13/repmgr.conf /export/home/postgres1/
chown postgres1:postgres1 /export/home/postgres1/repmgr.conf
 
# Start the REPMGR service for PostgreSQL version 13
systemctl start repmgr-13
 
# Monitor the REPMGR logs in real-time for any updates or events
tail -f /var/log/repmgr/repmgr.log

# Switch to superuser
sudo su -
 
# Install the PostgreSQL repository and server packages
yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
yum install -y postgresql13-server postgresql13-contrib
 
# Create a new user (replace with useradd or usermod based on requirements)
useradd -m -d /export/home/postgres1 postgres1
 
# Create necessary directories and set ownership
mkdir -p /DATA/postgresql/13/data
chown -R postgres1:postgres1 /DATA/postgresql
 
# Create directory for PostgreSQL runtime files
mkdir /var/run/postgresql
chown -R postgres1:postgres1 /var/run/postgresql
 
# Edit the systemd service file for PostgreSQL
vi /usr/lib/systemd/system/postgresql-13.service
 
# Add or modify the following lines:
User=postgres1
Group=postgres1
Environment=PGDATA=/DATA/postgresql/13/data/
 
# Reload systemd to apply changes
systemctl daemon-reload
 
# Check the status of PostgreSQL service
systemctl status postgresql-13
 
# Start the PostgreSQL service
systemctl start postgresql-13
 
# Tail the PostgreSQL log file for the specified day
tail -f /DATA/postgresql/13/data/log/postgresql-Mon.log  # Mon, Tue, Wed, Thu, Fri, Sat, Sun
 
# Enable PostgreSQL to start on boot
systemctl enable postgresql-13

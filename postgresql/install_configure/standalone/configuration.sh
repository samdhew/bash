# Switch to the PostgreSQL user
su - postgresql
 
# Check the PostgreSQL data directory
/usr/pgsql-13/bin/postgresql-13-check-db-dir /DATA/postgresql/13/data/
 
# Initialize the PostgreSQL database
/usr/pgsql-13/bin/initdb -D /DATA/postgresql/13/data/
 
# Check the PostgreSQL data directory again
/usr/pgsql-13/bin/postgresql-13-check-db-dir /DATA/postgresql/13/data/
 
# Change to temporary directory
cd /tmp
 
# Start PostgreSQL
/usr/pgsql-13/bin/pg_ctl -D /DATA/postgresql/13/data -l logfile start
 
# Connect to PostgreSQL and create a new database and user
psql -d postgres -c "create database postgres1"
psql -c "alter user postgres1 with password 'Abc_1234567'"  # Please use a strong password
 
# Stop PostgreSQL
/usr/pgsql-13/bin/pg_ctl -D /DATA/postgresql/13/data -l logfile stop
 
# Edit PostgreSQL configuration file
vi /DATA/postgresql/13/data/postgresql.conf
 
# Modify the following parameters in postgresql.conf
data_directory = '/DATA/postgresql/13/data/'
listen_addresses = '10.1.x.x'
max_connections = 500
shared_buffers = 2048MB  # 25% of memory upto 32GB RAM
idle_in_transaction_session_timeout = 300000
log_checkpoints = on
log_connections = on
log_disconnections = on
log_error_verbosity = default  # terse, default, or verbose
log_hostname = on
log_line_prefix = '%m [%p] %r '
log_statement = 'ddl'
port = 5432
superuser_reserved_connections = 3
work_mem = 64MB  # Start with 64MB upto 32GB
 
# Edit PostgreSQL pg_hba.conf file
vi /DATA/postgresql/13/data/pg_hba.conf
 
# Add the following lines to pg_hba.conf
host all all 10.1.x.x/32 md5       # Server IP
host all all 10.2.8.0/24 md5       # CIDR 1
host all all 10.3.x.x/22 md5       # CIDR 2
host all all 10.4.x.x/32 md5       # Server IP
 
# Comment out the default lines in pg_hba.conf
#local   all             all                                     trust
#host    all             all             127.0.0.1/32            trust
#host    all             all             ::1/128                 trust

# ORACLE_FDW Build on CentOS 7
 
# Navigate to the target directory
cd /DATA/postgresql/
 
# List Oracle Instant Client files
ls -la /home/oracle/oracle-instantclient11.2-*
 
# Copy Oracle Instant Client files to the current directory
cp /home/oracle/oracle-instantclient11.2-* .
 
# Install Oracle Instant Client RPM packages
rpm -ivh oracle-instantclient11.2-basic-11.2.0.4.0-1.x86_64.rpm
rpm -ivh oracle-instantclient11.2-sqlplus-11.2.0.4.0-1.x86_64.rpm
rpm -ivh oracle-instantclient11.2-devel-11.2.0.4.0-1.x86_64.rpm
 
# List Oracle FDW archive file
ls -la /home/oracle/oracle_fdw-ORACLE_FDW_2_4_0.tar.gz
 
# Copy Oracle FDW archive file to the current directory
cp /home/oracle/oracle_fdw-ORACLE_FDW_2_4_0.tar.gz .
 
# Extract Oracle FDW source code
tar -xvzf v2.3.15.tar.gz
cd oracle_fdw-ORACLE_FDW_2_4_0/
 
# Build Oracle FDW using the specified PostgreSQL configuration
make PG_CONFIG=/usr/pgsql-13/bin/pg_config
 
# Install Oracle FDW into the PostgreSQL environment
make PG_CONFIG=/usr/pgsql-13/bin/pg_config install

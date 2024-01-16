# PLV8 Build on CentOS 7
 
# Verify Python version
python3 --version
 
# Install Python3
yum install -y python3
 
# Install EPEL repository
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
 
# Download and install CentOS Software Collections Repository
wget http://mirror.centos.org/centos/7/extras/x86_64/Packages/centos-release-scl-rh-2-3.el7.centos.noarch.rpm
rpm -ivh centos-release-scl-rh-2-3.el7.centos.noarch.rpm
 
# Install additional packages
yum install -y epel-release
yum install -y build-essential
yum install -y postgresql13-devel.x86_64
yum install -y bzip2
yum install -y gcc
yum install -y gcc-c++
yum install -y clang
yum install -y llvm5.0
yum install -y centos-release-scl-rh
yum install -y llvm-toolset-7-llvm
yum install -y devtoolset-7
yum install -y llvm-toolset-7-clang
yum install -y libcxx
yum install -y libcxx-devel
yum install -y libaio
 
# Move repository RPM to the specified directory
mv centos-release-scl-rh-2-3.el7.centos.noarch.rpm /DATA/postgresql/
 
# Update dynamic linker run-time bindings
ldconfig
 
# Verify the availability of the library
ldconfig -p | grep libclntsh.so
 
# Edit dynamic linker configuration
vi /etc/ld.so.conf
 
# Download PLV8 source code
wget https://github.com/plv8/plv8/archive/v2.3.15.tar.gz
 
# Extract PLV8 source code
tar -xvzf v2.3.15.tar.gz
cd plv8-2.3.15/
 
# Build PLV8 using the specified PostgreSQL configuration
make PG_CONFIG=/usr/pgsql-13/bin/pg_config
 
# Install PLV8 into the PostgreSQL environment
make PG_CONFIG=/usr/pgsql-13/bin/pg_config install

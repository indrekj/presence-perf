sudo -s

sysctl -w net.ipv4.ip_forward=1
sysctl -w fs.file-max=12000500
sysctl -w fs.nr_open=20000500
ulimit -n 4000000
sysctl -w net.ipv4.tcp_mem='10000000 10000000 10000000'
sysctl -w net.ipv4.tcp_rmem='1024 4096 16384'
sysctl -w net.ipv4.tcp_wmem='1024 4096 16384'
sysctl -w net.core.rmem_max=16384
sysctl -w net.core.wmem_max=16384

echo "root soft nofile 4000000" >> /etc/security/limits.conf
echo "root hard nofile 4000000" >> /etc/security/limits.conf

# Update apt
yes | apt-get update

# Install erlang
wget https://packages.erlang-solutions.com/erlang/debian/pool/esl-erlang_22.0.7-1~ubuntu~bionic_amd64.deb
dpkg -i esl-erlang_22.0.7-1~ubuntu~bionic_amd64.deb

# Finish installing erlang
yes | apt-get install -f

# Install git and tsung dependencies
yes | apt-get install esl-erlang build-essential git gnuplot libtemplate-perl

# Install tsung
wget http://tsung.erlang-projects.org/dist/tsung-1.7.0.tar.gz
tar -xvf tsung-1.7.0.tar.gz
cd tsung-1.7.0/
./configure
make
make install
cd ..

# Clone repo
git clone https://github.com/indrekj/presence-perf.git
cd presence-perf/client

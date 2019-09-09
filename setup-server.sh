sudo -s

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

# Install elixir
wget https://packages.erlang-solutions.com/erlang/debian/pool/elixir_1.9.1-1~ubuntu~bionic_all.deb
dpkg -i elixir_1.9.1-1~ubuntu~bionic_all.deb

# Finish installing erlang and elixir
yes | apt-get install -f

# Install git
yes | apt-get -f install git

# Clone repo
git clone https://github.com/indrekj/presence-perf.git
cd presence-perf/server

# Build app
mix deps.get
MIX_ENV=prod mix release

# Run app
./start 1 4

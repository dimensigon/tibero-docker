#!/bin/bash
set -x

function dn() { return 0; } #Do Nothing.
function fdt() { date +%Y%m%d%H%M:%S:%N; }
function output() { echo -e "`fdt`:\e[92m$@\e[0m"; }

output "--- Installing OS Packages ---"
yum -q -y --nogpgcheck install java-1.8.0-openjdk-devel.x86_64 libibverbs net-tools ntp gcc \
gcc-c++ libstdc++-devel \
compat-libstdc++ libaio libaio.x86_64 libaio-devel net-tools \
kernel-headers kernel-devel perl make systemd tree wget curl supervisor openssh-server

yum -q clean packages

output "--- Creating Users and Groups ---"
groupadd -g 500 dba
useradd -g dba tibero

output "--- Downloading Tibero Database Software via WGET ---"
wget -q --load-cookies /tmp/cookies.txt \
"https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=12r6P0F7Jtf6ysnojcUcPbAFkCXbhu6S5' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=12r6P0F7Jtf6ysnojcUcPbAFkCXbhu6S5" \
-O /tmp/tibero6-bin-FS07_CS_2005-linux64-186930-opt-tested.tar.gz && rm -rf /tmp/cookies.txt

output "--- Untar Tibero Software ---"
su - tibero -c "tar -xf /tmp/tibero6-bin-FS07_CS_2005-linux64-186930-opt-tested.tar.gz"

output "--- Creating Users and Groups ---"
su - tibero -c "wget -q https://raw.githubusercontent.com/dimensigon/tibero-docker/master/bash_profile_tibero -O /home/tibero/.bash_profile"

output "--- Cleanup files: Tibero Software ---"
rm /tmp/tibero6-bin-FS07_CS_2005-linux64-186930-opt-tested.tar.gz

output "--- Downloading necessary files to run ---"
wget --load-cookies /tmp/cookies.txt \
"https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=15S-MuG_kytJR2LgmPugWbS17OajF3ex5' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=15S-MuG_kytJR2LgmPugWbS17OajF3ex5" \
-O /home/tibero/tibero6/license/license.xml && rm -rf /tmp/cookies.txt
chown tibero:dba /home/tibero/tibero6/license/license.xml 

output "--- ENTRYPOINT start.bash to tibero HOME  ---"
su - tibero -c "wget -q https://raw.githubusercontent.com/dimensigon/tibero-docker/master/start.bash \
-O /home/tibero/start.bash && chmod u+x /home/tibero/start.bash"

output "--- Finished!  ---"

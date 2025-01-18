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

output "--- Installing X11 Packages ---"

yum -q -y install xorg-x11-server-Xorg xorg-x11-xauth xorg-x11-apps xterm

yum -q clean packages

output "--- Creating Users and Groups ---"

groupadd -g 500 dba
useradd -g dba tibero


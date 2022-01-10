#!/bin/bash

print_network(){
	logfile="${XDG_CACHE_HOME:-/tmp}/netlog"
	[ -f "$logfile" ] || echo "0 0" > "$logfile"
	read -r rxprev txprev utimeprev < "$logfile"
	read utime rest </proc/uptime
	rx=$(cat /sys/class/net/enp5s0/statistics/rx_bytes)
	tx=$(cat /sys/class/net/enp5s0/statistics/tx_bytes)
	echo "$rx $tx $utime" > "$logfile"
	rxs="$(bc <<< "($rx - $rxprev) / ($utime-$utimeprev)")"
	txs="$(bc <<< "($tx - $txprev) / ($utime-$utimeprev)")"
	rxsh="$(numfmt --to=iec-i --suffix=B/s --format="%.2f" $rxs)"
	txsh="$(numfmt --to=iec-i --suffix=B/s --format="%.2f" $txs)"
	echo " $rxsh    $txsh"
}

	echo "$(print_network)"

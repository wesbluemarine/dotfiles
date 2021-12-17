#!/usr/bin/env bash

time=$(LC_ALL=C TZ='Europe/Rome' date '+%H:%M %a ')
date=$(date '+%d %B %Y')
echo '<span size="22000" face="segoeui" weight="light" foreground="#FFFFFF">'  $time'</span><span size="9000" face="segoeui" weight="light" foreground="#FFFFFF">' 
echo $date'</span>'

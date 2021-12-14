#!/usr/bin/env bash

time=$(LC_ALL=C TZ='Europe/Rome' date '+%H:%M %A ')
date=$(date '+%d %B %Y')
echo '<span size="20000" face="segoeui" weight="light" foreground="#FFFFFF">'  $time'</span><span size="10000" face="segoeui" weight="light" foreground="#FFFFFF">' 
echo $date'</span>'

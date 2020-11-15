#!/bin/bash

# Check every 2 seconds
FREQUENCY=2

# Interface to use (lo/)
INTERFACE="lo"

# Use network statistics to get a sample every two seconds of average kbps
# Run it against Termux localhost (lo) interface while darkhttpd/nginx is running
# Access your server's URL via another app eg Chrome/ES Explorer etc

downspeed()
{
    rx1=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
    sleep $FREQUENCY
    rx2=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
    rxdiff=$(echo "$rx2 - $rx1" | bc -l)
    rxtrue=$(echo "$rxdiff/1024/$FREQUENCY" | bc -l)

    printf "%.0f\n" "$rxtrue"
}

# Calculate and show current speed
while true;
do
    downspeed
done | stag --title "Download kbps" "$@"

#!/bin/bash

echo "========================"
echo "      SYSTEM INFO"
echo "========================"

# OS Info
echo "OS Information:"
if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "$NAME $VERSION"
else
    uname -a
fi

echo "------------------------"

# System Uptime
echo "System Uptime:"
uptime -p  # prints like "up 3 hours, 12 minutes"
echo "------------------------"

# CPU Usage
echo "CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print "CPU Load:", 100 - $8, "%"}'
echo "------------------------"

# Memory Usage
echo "Memory Usage (in MB):"
free -m | awk 'NR==2{printf "Used: %sMB / Total: %sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'
echo "------------------------"

# Disk Usage
echo "Disk Usage:"
df -h / | awk 'NR==2{printf "Used: %s / Total: %s (%s used)\n", $3,$2,$5}'
echo "------------------------"

# Top 5 Processes by CPU
echo "Top 5 Processes by CPU:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -6
echo "------------------------"

# Top 5 Processes by Memory
echo "Top 5 Processes by Memory:"
ps -eo pid,comm,%mem --sort=-%mem | head -6
echo "------------------------"

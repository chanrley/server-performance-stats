#!/bin/bash

# Get OS Version
echo ""
echo "=== OS Version ==="
cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2

# Get Load Average
echo ""
echo "=== Load Average ==="
uptime | grep -o "load average.*"

# Get Logged In Users
echo ""
echo "=== Logged In Users ==="
echo "Total users on system: $(wc -l < /etc/passwd)"

# Get Failed Login Attempts
echo ""
echo "=== Failed Login Attempts ==="
grep "Failed password" /var/log/auth.log 2>/dev/null | wc -l


# Get Uptime
echo ""
echo "=== Uptime ==="
uptime | awk -F, '{print $1}'



# Get CPU Usage
echo ""
echo "=== CPU Usage ==="
awk '/^cpu / {usage=($2+$3+$4+$5+$6+$7+$8) / ($2+$3+$4+$5+$6+$7+$8+$9) * 100; printf "Total CPU Usage: %.2f%%\n", usage}' /proc/stat

# Get Memory Usage
echo ""
echo "=== Memory usage ==="
grep -E "MemTotal|MemFree" /proc/meminfo | awk 'NR==1{total=$2} NR==2{free=$2} END{used=total-free; printf "Memory Used: %.2f%%\n", (used/total)*100}'

# Get Disk Usage
echo ""
echo "=== Disk Usage === "
df -h | grep -E "^/dev" | awk '{printf "s: %s (%.2f%% used)\n", $1, $3, $3, ($3/$2)*100}'

# Get Top 5 Processes by Memory
echo ""
echo "=== Top 5 Processes by Memory ==="
ps aux | tail -5


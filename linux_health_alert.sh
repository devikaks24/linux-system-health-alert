#!/bin/bash

# ===============================
# Linux System Health Alert
# Author: Devika K S
# ===============================

ALERT_EMAIL="devikaks3339@gmail.com"

LOG_DIR=~/Documents/linux-system-health-alert/logs/$(date +%F)
mkdir -p $LOG_DIR
LOG_FILE=$LOG_DIR/system_alert.log

echo "=======================================" >> $LOG_FILE
echo "System Health Check - $(date)" >> $LOG_FILE
echo "=======================================" >> $LOG_FILE

# Memory Usage Check
mem_usage=$(free | awk '/Mem/ {printf("%d", $3/$2 * 100)}')
echo "Memory Usage: $mem_usage%" >> $LOG_FILE

if [ "$mem_usage" -gt 80 ]; then
    echo "Memory High Alert: $mem_usage%" >> $LOG_FILE
    #!/bin/bash

# -------- System Health Monitoring Script -------- #
# Author: Devika KS
# Purpose: Send alerts when system usage is high

HOSTNAME=$(hostname)
DATE=$(date)

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
MEM_USAGE=$(free | awk '/Mem/ {printf("%.2f"), $3/$2 * 100}')
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

CPU_THRESHOLD=1
MEM_THRESHOLD=1
DISK_THRESHOLD=1

ALERT=false
MESSAGE="System Health Alert on $HOSTNAME
Date: $DATE

CPU Usage: $CPU_USAGE %
Memory Usage: $MEM_USAGE %
Disk Usage: $DISK_USAGE %
----------------------------------
"

# CPU Check
if (( ${CPU_USAGE%.*} > CPU_THRESHOLD )); then
  MESSAGE+="⚠ High CPU Usage Detected\n"
  ALERT=true
fi

# Memory Check
if (( ${MEM_USAGE%.*} > MEM_THRESHOLD )); then
  MESSAGE+="⚠ High Memory Usage Detected\n"
  ALERT=true
fi

# Disk Check
if (( DISK_USAGE > DISK_THRESHOLD )); then
  MESSAGE+="⚠ High Disk Usage Detected\n"
  ALERT=true
fi

# Send alert only if required
if [ "$ALERT" = true ]; then
  echo -e "$MESSAGE" | mail -s "🚨 System Health Alert on $HOSTNAME" devikaks3339@gmail.com
else
  echo "System normal at $DATE" >> ~/Documents/linux-system-health-alert/logs/cron.log
fi


#!/bin/bash

# ====== Project: Linux System Health Alert ======

# Email where alerts will be sent
EMAIL="devikaks3339@gmail.com"

# Alert thresholds (1 = will always trigger for testing)
CPU_THRESHOLD=1
MEM_THRESHOLD=1
DISK_THRESHOLD=1

# Log and temporary alert file
LOG_FILE="$HOME/Documents/linux-system-health-alert/logs/health_$(date '+%Y-%m-%d').log"
ALERT_FILE="/tmp/system_alert.txt"
> $ALERT_FILE  # clear alert file before each run

# ===== CPU Usage Check =====
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
CPU_INT=${CPU_USAGE%.*}

if [ "$CPU_INT" -ge "$CPU_THRESHOLD" ]; then
  echo "⚠ HIGH CPU USAGE: ${CPU_INT}%" >> $ALERT_FILE
fi

# ===== MEMORY Usage Check =====
MEM_USAGE=$(free | awk '/Mem/{printf("%.0f"), $3/$2 * 100}')
if [ "$MEM_USAGE" -ge "$MEM_THRESHOLD" ]; then
  echo "⚠ HIGH MEMORY USAGE: ${MEM_USAGE}%" >> $ALERT_FILE
fi

# ===== DISK Usage Check =====
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
if [ "$DISK_USAGE" -ge "$DISK_THRESHOLD" ]; then
  echo "⚠ DISK USAGE HIGH: ${DISK_USAGE}%" >> $ALERT_FILE
fi

# ===== TOP 5 MEMORY CONSUMING PROCESSES =====
echo -e "\nTop 5 Processes:" >> $ALERT_FILE
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -6 >> $ALERT_FILE

# ===== SAVE REPORT =====
echo -e "\nSystem Report Saved: $LOG_FILE\n"
date >> $LOG_FILE
cat $ALERT_FILE >> $LOG_FILE

# ===== SEND EMAIL IF ALERTS EXIST =====
if [ -s "$ALERT_FILE" ]; then
  mail -s "Linux System Health Alert ⚠" "$EMAIL" < $ALERT_FILE
fi


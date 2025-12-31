# 🟢 Linux System Health Alert

**Author:** Devika K S  
**Project:** Linux system monitoring with automated email alerts

---

## Overview

This project monitors Linux system health, including **CPU usage, memory usage, and disk usage**, and automatically sends email alerts if thresholds are exceeded.  
It also logs system status and top 5 memory-consuming processes for easy monitoring.  

This project demonstrates **basic DevOps skills**: automation, cron scheduling, and email alerts using Gmail SMTP.

---

## Features

- Monitors CPU, Memory, and Disk usage  
- Sends automated email alerts if thresholds are exceeded  
- Logs all system reports in a `logs/` folder  
- Shows top 5 memory-consuming processes  
- Fully automated using **cron jobs**  
- Uses **msmtp** for sending Gmail alerts

---

## Prerequisites

- Ubuntu Linux  
- Gmail account with **App Password** enabled  
- Packages installed: `mailutils`, `msmtp`

---

## Setup Instructions

1. **Clone or create project folder:**

```bash
mkdir -p ~/Documents/linux-system-health-alert/logs
cd ~/Documents/linux-system-health-alert

2. **Install packages:**

sudo apt update
sudo apt install mailutils msmtp msmtp-mta -y


3. Configure Gmail in ~/.msmtprc with App Password

4. Create system_health_alert.sh script and make it executable:

chmod +x system_health_alert.sh


5. Test manually:

./system_health_alert.sh


6. Setup cron job:

crontab -e


Add:

*/10 * * * * /home/<username>/Documents/linux-system-health-alert/system_health_alert.sh >> /home/<username>/Documents/linux-system-health-alert/logs/cron.log 2>&1


Replace <username> with your Ubuntu username

Logs

Reports saved in logs/ with date stamps

Cron logs in logs/cron.log

Outcome

Hands-on Linux, Bash scripting, cron automation

Demonstrates basic DevOps skills

Real-time system health alerts via email

Author

Devika K S


---

This is **ready to copy-paste** into `README.md`.  

If you want, I can also **give a final folder structure + .gitignore setup** so your GitHub repo looks clean and professional.  

Do you want me to do that?

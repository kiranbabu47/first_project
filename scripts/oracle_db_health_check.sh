#!/bin/bash

set -e

echo "========================================"
echo "     ORACLE PRIMARY HEALTH CHECK"
echo "========================================"

echo "===== HOSTNAME ====="
hostname

echo "===== OS ====="
cat /etc/os-release | head -5

echo "===== UPTIME ====="
uptime

echo "===== MEMORY ====="
free -h

echo "===== DISK ====="
df -h /

echo "===== ORACLE PROCESSES ====="
ps -ef | grep '[o]ra_pmon' || true

echo "===== ORACLE LISTENER ====="
lsnrctl status || true

echo "========================================"
echo "Oracle health check completed"
echo "========================================"

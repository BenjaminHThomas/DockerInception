#!/bin/bash

# Enable bash debugging
set -x

# Print system information
echo "=== System Information ==="
date
pwd
id
ls -la /web_data
ls -la /var/run/vsftpd
cat /etc/vsftpd.conf

# Check if vsftpd is installed
if ! command -v vsftpd &> /dev/null; then
    echo "ERROR: vsftpd is not installed!"
    exit 1
fi

# Try to start vsftpd in debug mode
echo "Starting vsftpd..."
exec /usr/sbin/vsftpd /etc/vsftpd.conf
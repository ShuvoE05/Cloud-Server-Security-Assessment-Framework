#!/bin/bash

echo "================================================"
echo "       CLOUD SERVER SECURITY ASSESSMENT"
echo "================================================"

if [ "$#" -lt 2 ]
then
    echo "ERROR: Missing required arguments."
    echo
    echo "Usage:"
    echo "$0 <username> <failed_attempts>"
    exit 1
fi

target_user="$1"
failed_attempts="$2"

current_user=$(whoami)
current_hostname=$(hostname)
current_date=$(date)
system_uptime=$(uptime)
listening_services=$(ss -tuln)

echo
echo "=============== SYSTEM INFO =================="

echo "Target User       : $target_user"
echo "Current User      : $current_user"
echo "Hostname          : $current_hostname"
echo "Date              : $current_date"
echo "Uptime            : $system_uptime"

echo
echo "=============== IDENTITY CHECK ==============="

if [ "$target_user" = "$current_user" ]
then
    echo "PASS: Target user matches current user."
else
    echo "WARNING: Target user mismatch detected."
fi

echo
echo "============== LOGIN RISK CHECK =============="

if [ "$target_user" = "root" ] || [ "$failed_attempts" -gt 10 ]
then
    severity="CRITICAL"
    echo "Severity: $severity"
    echo "Action: Immediate investigation required."

elif [ "$target_user" = "admin" ] && [ "$failed_attempts" -gt 5 ]
then
    severity="HIGH"
    echo "Severity: $severity"
    echo "Action: Review authentication activity."

elif [ "$failed_attempts" -gt 3 ]
then
    severity="MEDIUM"
    echo "Severity: $severity"
    echo "Action: Monitor authentication activity."

else
    severity="LOW"
    echo "Severity: $severity"
    echo "Action: No immediate action required."
fi

echo
echo "============= NETWORK EXPOSURE ==============="

echo "$listening_services"

if [ -z "$listening_services" ]
then
    echo
    echo "Network Status: LOW EXPOSURE"
else
    echo
    echo "Network Status: REVIEW REQUIRED"
fi

echo
echo "============= SECURITY SUMMARY ==============="

for check in Identity Authentication Network
do
    echo "Completed Check: $check"
done

echo
echo "Current Security Severity: $severity"

if [ "$severity" = "CRITICAL" ]
then
    echo "Final Status: IMMEDIATE INVESTIGATION REQUIRED"
    break_status="stop"

elif [ "$severity" = "HIGH" ]
then
    echo "Final Status: SECURITY REVIEW REQUIRED"
    break_status="review"

else
    echo "Final Status: ROUTINE MONITORING"
    break_status="monitor"
fi

echo
echo "================================================"
echo "             ASSESSMENT COMPLETE"
echo "================================================"

#!/bin/bash

# first check if user gave us a filename
if [ $# -eq 0 ]; then
    echo "Usage: ./q3_log_analyzer.sh <logfile>"
    exit 1
fi

logfile=$1

# check the file actually exists
if [ ! -f "$logfile" ]; then
    echo "Error: File '$logfile' not found."
    exit 1
fi

# check it's not empty
if [ ! -s "$logfile" ]; then
    echo "Error: Log file is empty."
    exit 1
fi

echo ""
echo "=== LOG FILE ANALYSIS ==="
echo "Log File: $logfile"
echo ""

# total lines = total entries
total=$(wc -l < "$logfile")
echo "Total Entries: $total"

echo ""
echo "Unique IP Addresses:"
# pull first column (the IP), sort and deduplicate
unique_ips=$(awk '{print $1}' "$logfile" | sort | uniq)
ip_count=$(echo "$unique_ips" | wc -l)
echo "Count: $ip_count"
while IFS= read -r ip; do
    echo " - $ip"
done <<< "$unique_ips"

echo ""
echo "Status Code Summary:"
# status code is the last column in each line
awk '{print $NF}' "$logfile" | sort | uniq -c | while read count code; do
    echo " $code: $count requests"
done

echo ""
echo "Top 3 IP Addresses by requests:"
awk '{print $1}' "$logfile" | sort | uniq -c | sort -rn | head -3 | \
awk '{print NR". "$2" - "$1" requests"}'

echo ""
echo "Most Frequently Accessed Page:"
# page is inside quotes, it's the 3rd quoted word - grab field 7
awk '{print $7}' "$logfile" | sort | uniq -c | sort -rn | head -1 | \
awk '{print " "$2" ("$1" hits)"}'



echo "=== USER STATISTICS ==="
echo ""
total_users=$(awk -F: 'END {print NR}' /etc/passwd)

sys_users=$(awk -F: '$3 < 1000 {count++} END {print count}' /etc/passwd)


reg_users=$(awk -F: '$3 >= 1000 && $3 != 65534 {count++} END {print count}' /etc/passwd)


logged_in=$(who | awk '{print $1}' | sort -u | wc -l)

echo "Total Users: $total_users"
echo "System Users (UID < 1000): $sys_users"
echo "Regular Users (UID >= 1000): $reg_users"
echo "Currently Logged In: $logged_in"

echo ""
echo "=== REGULAR USER DETAILS ==="
echo ""
printf "%-15s %-6s %-25s %s\n" "Username" "UID" "Home Directory" "Shell"
printf "%-15s %-6s %-25s %s\n" "--------" "---" "--------------" "-----"


awk -F: '$3 >= 1000 && $3 != 65534 {printf "%-15s %-6s %-25s %s\n", $1, $3, $6, $7}' /etc/passwd

echo ""
echo "=== GROUP INFORMATION ==="
echo ""
while IFS=: read -r grpname pass gid members; do
    
    if [ -z "$members" ]; then
        count=0
    else
        count=$(echo "$members" | tr ',' '\n' | wc -l)
    fi
    echo "Group: $grpname | Members: $count"
done < /etc/group

echo ""
echo "=== SECURITY ALERTS ==="
echo ""
echo "Users with root privileges (UID 0):"
awk -F: '$3 == 0 {print " - "$1}' /etc/passwd

echo""
no_pass=$(awk -F: '$2 == "" {print $1}' /etc/shadow 2>/dev/null)
if [ -z "$no_pass" ]; then
    echo "All users have passwords set."
else
    echo "Users WITHOUT passwords (security risk):"
    echo "$no_pass"
fi

echo ""

echo "Users who have never logged in:"
lastlog | awk 'NR>1 && /Never logged in/ {print " - "$1}'

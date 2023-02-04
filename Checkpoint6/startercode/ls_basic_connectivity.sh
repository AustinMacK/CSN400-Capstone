# Flush All Iptables Chains/Firewall rules
echo "-------------------------------------------"
echo "Flush All Iptables Chains/Firewall rules"
iptables -F

# Delete all Iptables Chains
echo "-------------------------------------------"
echo "Delete all Iptables Chains"
iptables -X

# Allow any INPUT tcp traffic if RELATED or ESTABLISHED
echo "-------------------------------------------"
echo "Allow any INPUT tcp traffic if RELATED or ESTABLISHED"
iptables -A INPUT -p tcp -m state --state RELATED,ESTABLISHED -j ACCEPT

# Allow icmp traffic into the VM
echo "-------------------------------------------"
echo "Allow icmp traffic into the VM"
iptables -A INPUT -p icmp -j ACCEPT

# Allow any traffic from loopback interface into the VM
echo "-------------------------------------------"
echo "Allow any traffic from loopback interface into the VM"
iptables -A INPUT -i lo -j ACCEPT

# Allow any traffic from Linux Router on SSH port 22 into the VM 
echo "-------------------------------------------"
echo "Allow any traffic from Linux Router on SSH port 22 into the VM"
echo "SSH"
iptables -A INPUT -p tcp -s 192.168.xx.32/27 --dport 22 -j ACCEPT

# Allow any traffic from Desktop Client on SSH port 22 into the VM 
echo "-------------------------------------------"
echo "Allow any traffic from Deskktop Client Router on SSH port 22 into the VM"
echo "SSH"
iptables -A INPUT -p tcp -s xx.xx.xx.xx/24 --dport 22 -j ACCEPT

# Allow any traffic on HTTP port 80 into the VM
echo "-------------------------------------------"
echo "HTTP"
echo "Allow any traffic on HTTP port 80 into the VM"
iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# Allow any traffic on SQL port 3306 into the VM
echo "-------------------------------------------"
echo "Allow any traffic on SQL port 3306 into the VM"
echo "SQL"
iptables -A INPUT -p tcp --dport 3306 -j ACCEPT

# Log instead of DROPPING
echo "-------------------------------------------"
echo "Add a rule to LOG instead of DROPPING INPUT packets"
iptables -A INPUT -p all -m limit --limit 10/s -j LOG  --log-prefix "TO_DROP_INPUT"

# Reject all other INPUT traffic
# echo "-------------------------------------------"
# echo "Reject all other INPUT traffic"
# iptables -A INPUT -j DROP

# Reject all FORWARD traffic from this machine
echo "-------------------------------------------"
echo "Reject all FORWARD traffic from this machine"
iptables -A FORWARD -j DROP

# Allow all output traffic from this machine
echo "-------------------------------------------"
echo "Allow all output traffic from this machine"
iptables -A OUTPUT -j ACCEPT

# List current iptables status
echo "-------------------------------------------"
echo "list current iptables status"
iptables -nvL --line-number

#!/bin/bash
# iptables configuration file

# Flush all current rules from iptables
iptables -F

# Set default policies for INPUT, FORWARD and OUTPUT chains
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Set access for localhost
iptables -A INPUT -i lo -j ACCEPT

# Set access for internal network
iptables -A INPUT -i eth1 -j ACCEPT

# Allow access to common ports
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 3000 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 25565 -j ACCEPT
iptables -A INPUT -p tcp --dport 25566 -j ACCEPT

# Accept packets belonging to established and related connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Save settings with /sbin/service iptables save
# List iptables chains with 'iptables -L -v'
/sbin/service iptables save
iptables -L -v

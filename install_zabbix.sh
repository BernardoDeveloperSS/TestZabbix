#!/bin/bash

mkdir zabbix
cd zabbix

# install the zabbix
rpm -Uvh https://repo.zabbix.com/zabbix/4.0/rhel/7/x86_64/zabbix-release-4.0-2.el7.noarch.rpm
yum install -y zabbix zabbix-agent

# configure zabbix_agent
name=$(hostnamectl | egrep -i "Static hostname" | awk '{print $NF}')
echo -e "Server=10.10.1.157,179.110.69.19/32,186.230.32.171/32\nHostname=$name" > /etc/zabbix/zabbix_agentd.conf

# save the server name in a file
echo "$name" > ./server_name.txt

# firewall configuration
iptables -A INPUT -p tcp -s 10.10.1.157 --dport 10050 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp -s 179.110.69.19/32 --dport 10050 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp -s 186.230.32.171/32 --dport 10050 -m state --state NEW,ESTABLISHED -j ACCEPT

# restart zabbix agent
service zabbix-agent restart

# TODO: copiar os scripts
# restart zabbix agent
service zabbix-agent restart

# TODO: copiar os scripts

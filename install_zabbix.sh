#!/bin/bash

mkdir zabbix
cd zabbix

# install the zabbix
rpm -Uvh https://repo.zabbix.com/zabbix/4.0/rhel/7/x86_64/zabbix-release-4.0-2.el7.noarch.rpm
yum install -y zabbix zabbix-agent

# configure zabbix_agent
name=$(hostnamectl | egrep -i "Static hostname" | awk '{print $NF}')
echo -e "Server=10.10.1.157,179.110.69.19/32,186.230.32.171/32\nHostname=$name" >> /etc/zabbix/zabbix_agentd.conf

# save the server name in a file
echo "$name" >> ./server_name.txt

# firewall configuration
iptables -A INPUT -p tcp -s 10.10.1.157 --dport 10050 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp -s 179.110.69.19/32 --dport 10050 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp -s 186.230.32.171/32 --dport 10050 -m state --state NEW,ESTABLISHED -j ACCEPT

# restart zabbix agent
service zabbix-agent restart

cd /etc/zabbix/
mkdir scripts/
cd scripts/

wget "https://raw.githubusercontent.com/BernardoDeveloperSS/TestZabbix/main/check_agentes_presos.sh"
wget "https://raw.githubusercontent.com/BernardoDeveloperSS/TestZabbix/main/check_asterisk.sh"
wget "https://raw.githubusercontent.com/BernardoDeveloperSS/TestZabbix/main/check_asterisk_uptime.sh"
wget "https://raw.githubusercontent.com/BernardoDeveloperSS/TestZabbix/main/check_asteriskdb_users.sh"
wget "https://raw.githubusercontent.com/BernardoDeveloperSS/TestZabbix/main/check_conversao.sh"
wget "https://raw.githubusercontent.com/BernardoDeveloperSS/TestZabbix/main/check_gravacao_30.sh"
wget "https://raw.githubusercontent.com/BernardoDeveloperSS/TestZabbix/main/check_gravacao_ontem.sh"
wget "https://raw.githubusercontent.com/BernardoDeveloperSS/TestZabbix/main/check_gravacao_tamanho.sh"
wget "https://raw.githubusercontent.com/BernardoDeveloperSS/TestZabbix/main/check_gravacoes_ontem.sh"
wget "https://raw.githubusercontent.com/BernardoDeveloperSS/TestZabbix/main/check_listener.sh"
wget "https://raw.githubusercontent.com/BernardoDeveloperSS/TestZabbix/main/check_manager.sh"
wget "https://raw.githubusercontent.com/BernardoDeveloperSS/TestZabbix/main/check_manutencao_sql.sh"
wget "https://raw.githubusercontent.com/BernardoDeveloperSS/TestZabbix/main/check_montagem_samba.sh"
wget "https://raw.githubusercontent.com/BernardoDeveloperSS/TestZabbix/main/check_status_by_sqlserver.sh"
wget "https://raw.githubusercontent.com/BernardoDeveloperSS/TestZabbix/main/check_wav.sh"
wget "https://raw.githubusercontent.com/BernardoDeveloperSS/TestZabbix/main/default_sql.sh"

echo -e "" > /etc/zabbix/zabbix_agentd.conf

#!/bin/bash

# install the zabbix
rpm -Uvh https://repo.zabbix.com/zabbix/4.0/rhel/7/x86_64/zabbix-release-4.0-2.el7.noarch.rpm
yum install -y zabbix zabbix-agent

# configure zabbix_agent
name=$(hostnamectl | egrep -i "Static hostname" | awk '{print $NF}')
echo -e "Server=10.10.1.157,179.110.69.19/32,186.230.32.171/32\nHostname=$name" > /etc/zabbix/zabbix_agentd.conf

# save the information of name_client in github
USERNAME="BernardoDeveloperSS"
REPO="TestZabbix"
FILE_PATH="names.txt"
TOKEN="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"

# Content to be updated
NEW_CONTENT="This is the updated content."

# Get the current file content
CURRENT_CONTENT=$(curl -s -H "Authorization: token $TOKEN" \
    "https://api.github.com/repos/$USERNAME/$REPO/contents/$FILE_PATH" | \
    jq -r .content | base64 -d)

# Update the content
UPDATED_CONTENT=$(echo "$name" | sed "s|.*|${name}|")

# Encode the updated content to base64
ENCODED_CONTENT=$(echo -n "$UPDATED_CONTENT" | base64)

# Commit the changes
curl -X PUT -H "Authorization: token $TOKEN" \
    -d "{\"message\": \"Update file content\", \"content\": \"$ENCODED_CONTENT\", \"sha\": \"$(curl -s -H "Authorization: token $TOKEN" \
    "https://api.github.com/repos/$USERNAME/$REPO/contents/$FILE_PATH" | \
    jq -r .sha)\"}" \
    "https://api.github.com/repos/$USERNAME/$REPO/contents/$FILE_PATH"

# firewall configuration
iptables -A INPUT -p tcp -s 10.10.1.157 --dport 10050 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp -s 179.110.69.19/32 --dport 10050 -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp -s 186.230.32.171/32 --dport 10050 -m state --state NEW,ESTABLISHED -j ACCEPT

# restart zabbix agent
service zabbix-agent restart

# TODO: copiar os scripts

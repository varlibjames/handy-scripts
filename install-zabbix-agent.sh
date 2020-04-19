#!/bin/bash
#
# Installs and configures the zabbix agent on a linux host
#
# To run, call as root:
# bash <(curl -sL https://github.com/varlibjames/handy-scripts/raw/master/install-zabbix-agent.sh)
#

function InstallZabbix() {
    apt update
    apt install -y zabbix-agent

    sed -i -e "s/# EnableRemoteCommands=0/EnableRemoteCommands=1/g" /etc/zabbix/zabbix_agentd.conf
    sed -i -e "s/Server=127.0.0.1/Server=192.168.88.20/g" /etc/zabbix/zabbix_agentd.conf
    sed -i -e "s/ServerActive=127.0.0.1/ServerActive=192.168.88.20/g" /etc/zabbix/zabbix_agentd.conf
    systemctl restart zabbix-agent
    systemctl enable zabbix-agent
}


if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

InstallZabbix

exit
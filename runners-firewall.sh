#!/bin/bash
sudo firewall-cmd --permanent --zone=trusted --add-interface=docker0
sudo firewall-cmd --permanent --zone=trusted --add-service=cockpit
sudo firewall-cmd --permanent --direct --add-rule ipv4 filter OUTPUT 0 -p icmp --icmp-type timestamp-reply -j DROP
sudo firewall-cmd --permanent --direct --add-rule ipv4 filter INPUT 0 -p icmp --icmp-type timestamp-request -j DROP
for zone in $(sudo firewall-cmd --get-zones); do
    sudo firewall-cmd --zone=$zone --add-port=53/tcp --permanent
    sudo firewall-cmd --zone=$zone --add-port=53/udp --permanent
done
sudo firewall-cmd --reload
echo
echo "Firewall rules configured"
echo
sudo firewall-cmd --list-all
sudo firewall-cmd --direct --get-rules ipv4 filter OUTPUT
sudo firewall-cmd --direct --get-rules ipv4 filter INPUT


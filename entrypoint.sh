#!/bin/sh

set -e

# start logging
rsyslogd

# enable IP forwarding
sysctl -w net.ipv4.ip_forward=1

# configure firewall
iptables -t nat -A POSTROUTING -s 172.31.99.0/24 -o eth0 -j MASQUERADE
iptables -A FORWARD -s 172.31.99.0/24 -p tcp -m tcp --tcp-flags FIN,SYN,RST,ACK SYN -j TCPMSS --set-mss 1356

sed -i "s/username/$USERNAME/g" /etc/ppp/chap-secrets
sed -i "s/password/$PASSWORD/g" /etc/ppp/chap-secrets

exec "$@"


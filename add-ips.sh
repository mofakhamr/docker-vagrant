#!/bin/bash
# quick script to bind some ips to expose docker containers to lan
sudo ip addr add 192.168.1.41/24 dev eth0
sudo ip addr add 192.168.1.42/24 dev eth0

#!/bin/sh

#The third line of the "ifconfig -s" command is going to start
#With the interface name of the most used / most important network.
#We need to capture that to make changes to it.
v1=$(ifconfig -s | awk '{print $1}') #The beginnings of all lines
v2=$(echo $v1 | awk '{print $3}')    #The beginning of the THIRD line!
echo ""
echo "Your current routing table is:"
netstat -r
echo ""
echo "Let's make a few changes..."
sudo ifconfig $v2 172.16.200.20 netmask 255.255.255.0 up
sudo route add -net 172.16.200.0 netmask 255.255.255.0 $v2
sudo route add default gw 172.16.200.1 $v2
sleep 3
echo "Here we go:"
sleep 1
netstat -r
echo "There..."
echo ""
echo "If you have any trouble connecting to the Internet,"
echo "just restart your computer. :-)"
echo ""


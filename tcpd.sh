#!/bin/bash

TMPF=$(mktemp /tmp/t.XXXXXX)
trap 'rm -f $TMPF; exit' INT ERR EXIT

BLUE='\033[1;34m'
RESET='\033[0m'

clear
echo -e "${BLUE}TCPDUMP:
	-don't resolve hostnames or portnames
	-give maximally human-readable timestamp output
	-show packet's contents in both HEX and ASCII, also show ethernet header
	-medium verbosity
	-get the whole capture, don't limit
	-dump 2 packets, then stop
	-to or from ports 80 or 443${RESET}"
echo ""
sudo tcpdump -nnttttXXvvs 0 -c2 port 80 || 443
sleep 2
echo ""
echo -e "${BLUE}TCPDUMP:
	-capture next 5 ACK packets, then stop
	-capture them in a temp file${RESET}"
echo ""
sudo tcpdump 'tcp[13] & 16!=0' -c5 -w $TMPF
echo ""
echo -e "${BLUE}TCPDUMP:
	-read them back from file${RESET}"
echo ""
sudo tcpdump -r $TMPF | more
echo ""
sleep 2
echo -e "${BLUE}THAT'S IT! BYE!${RESET}"
echo "" 


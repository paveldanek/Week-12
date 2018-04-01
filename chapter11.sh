#!/bin/bash

TMPFILE1=$(mktemp /tmp/im1.XXXXXX)
TMPFILE2=$(mktemp /tmp/im2.XXXXXX)
trap 'rm -f $TMPFILE1 $TMPFILE2; echo -e "\n\nCIAO!"; exit' INT ERR
# Trap applies, if script ended under circumstances: 	INT(erruption <CTRL>+<C>)
# 							ERR(or, where program exits)
# 							EXIT (where program ends)

case $# in
    0)	echo "$0: Please give your name as an argument when running this script.";
	exit;;
    1)	clear; first=$1; echo "What's your last name, $1?"; read last;;
    *)	clear; first=$1; last=$2;;
esac
h=$(date +%H)
if [ $h -ge 0 ] && [ $h -le 11 ]; then
    echo "Good morning, $first $last!"
elif [ $h -ge 12 ] && [ $h -le 16 ]; then
    echo "Good afternoon, $first $last!"
else echo "Good evening, $first $last!"
fi
sleep 2
# next, using an example from the book
echo -e "\nLet's se if any device interrupts happen in the next 2 seconds, $first:"
cat /proc/interrupts > $TMPFILE1
sleep 2
cat /proc/interrupts > $TMPFILE2
sleep 1
diff $TMPFILE1 $TMPFILE2 | more
sleep 1
echo -e "\nAll that happened in 2 seconds, $first."
sleep 2
ls -la > $TMPFILE1
q=$(wc -l $TMPFILE1 | awk '{print $1}')
declare -i w=0
w=$q-1
echo -e "\nAnd just to let you know, $first, your current directory contains"
echo "$w items, including hidden ones."
sleep 2
echo -e "\nThis is where you get off, Mr./Ms. $last."
echo ""
rm -f $TMPFILE1 $TMPFILE2


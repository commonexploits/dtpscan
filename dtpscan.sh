#!/usr/bin/env bash
# DTP Scan
# Daniel Compton
# www.commonexploits.com
# contact@commexploits.com
# Twitter = @commonexploits
# 13/10/2013
# Requires tshark
# Tested on Bactrack 5 and Kali with Cisco devices
# Version 1.0 - soon will be integrated into Froger version 2.


DTPSEC="90" # number of seconds to sniff for DTP. Suggest 90 as packets are sent every 30-60 seconds depending on the DTP mode.
VERSION="1.0"

clear
echo -e "\e[00;32m########################################################\e[00m"
echo "***   DTPScan - The VLAN DTP SCanner $VERSION  ***"
echo ""
echo "***   Detects DTP modes for VLAN Hopping ***"
echo -e "\e[00;32m########################################################\e[00m"

#Check for tshark
which tshark >/dev/null
if [ $? -eq 1 ]
	then
		echo -e "\e[01;31m[!]\e[00m Unable to find the required tshark program, install and try again."
		echo ""
		exit 1
fi



echo ""
echo -e "\e[01;32m[-]\e[00m The following Interfaces are available"
echo ""
ifconfig | grep -o "eth.*" |cut -d " " -f1
echo ""
echo -e "\e[1;31m----------------------------------------------------------\e[00m"
echo -e "\e[01;31m[?]\e[00m Enter the interface to scan from as the source"
echo -e "\e[1;31m----------------------------------------------------------\e[00m"
read INT
ifconfig | grep -i -w "$INT" >/dev/null

if [ $? = 1 ]
	then
		echo ""
		echo -e "\e[01;31m[!]\e[00m Sorry the interface you entered does not exist! - check and try again."
		echo ""
		exit 1
fi


echo ""
echo -e "\e[01;32m[-]\e[00m Now Sniffing DTP packets on interface $INT for "$DTPSEC" seconds."
echo ""

tshark -a duration:$DTPSEC -i $INT -R "dtp" -x -V >dtp.tmp 2>&1

cat dtp.tmp |grep "0 packets captured" >/dev/null

if [ $? = 0 ]

	then
			echo ""
			echo -e "\e[01;31m[!]\e[00m I didn't find any DTP packets. DTP is probably in 'switchport mode access' or 'switchport nonegotiate' modes."
			echo ""
			echo -e "\e[01;31m[!]\e[00m DTP VLAN attacks will not be possible."
			echo ""
			rm dtp.tmp 2>/dev/null
			exit 0
fi


DTPMODE=$(cat dtp.tmp |grep -o "Status: 0x.*" |awk '{ print $NF }' | sort --unique |head -1)
	if [ $DTPMODE = "0x03" ]
		then
			echo ""
			echo -e "\e[01;32m[+]\e[00m DTP was found enabled in it's default state of 'Auto'."
			echo ""
			echo -e "\e[01;32m[+]\e[00m VLAN hopping will be possible."
			echo ""

	elif [ $DTPMODE = "0x83" ]
		then
			echo ""
			echo -e "\e[01;32m[+]\e[00m DTP was found enabled in mode 'switchport mode dynamic desirable'."
			echo ""
			echo -e "\e[01;32m[+]\e[00m VLAN hopping should be possible."
			echo ""

	elif [ $DTPMODE = "0x04" ]
		then
			echo ""
			echo -e "\e[01;32m[+]\e[00m DTP was found enabled in mode 'switchport mode dynamic desirable'."
			echo ""
			echo -e "\e[01;32m[+]\e[00m VLAN hopping should be possible."
			echo ""

	elif [ $DTPMODE = "0x81" ]
		then
			echo ""
			echo -e "\e[01;32m[+]\e[00m DTP was found enabled in Trunk mode 'switchport mode trunk'."
			echo ""
			echo -e "\e[01;31m[!]\e[00m DTP VLAN attacks will not be possible."
			echo ""
	elif [ $DTPMODE = "0xa5" ]
		then
			echo ""
			echo -e "\e[01;32m[+]\e[00m DTP was found enabled in Trunk mode 'switchport mode trunk 802.1Q'. with 802.1Q encapsulation forced"
			echo ""
			echo -e "\e[01;31m[!]\e[00m DTP VLAN attacks will not be possible."
			echo ""

	elif [ $DTPMODE = "0x42" ]
		then
			echo ""
			echo -e "\e[01;32m[+]\e[00m DTP was found enabled in Trunk mode 'switchport mode trunk ISL'. with ISL encapsulation forced"
			echo ""
			echo -e "\e[01;31m[!]\e[00m DTP VLAN attacks will not be possible."
			echo ""

	elif [ $DTPMODE = "0x84" ]
		then
			echo ""
			echo -e "\e[01;32m[+]\e[00m DTP was found enabled in mode 'switchport mode dynamic auto'."
			echo ""
			echo -e "\e[01;32m[+]\e[00m VLAN hopping should be possible."
			echo ""

	elif [ $DTPMODE = "0x02" ]
		then
			echo ""
			echo -e "\e[01;32m[+]\e[00m DTP was found enabled in mode 'switchport mode access'."
			echo ""
			echo -e "\e[01;31m[!]\e[00m DTP VLAN attacks will not be possible."

	fi

rm dtp.tmp 2>/dev/null
exit 0

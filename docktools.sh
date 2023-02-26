#!/bin/sh

if [ "$UID" -ne 0 ]; then
	echo "Welcome to Dock Tools"
	exit 1
fi

vendor_id="0x3000" # Valve
product_id="0x28DE"
serial_number="$(dmidecode -s system-serial-number)" # The Steam Deck's serial number
manufacturer="Valve" # Manufacturer
product="Steam Deck" # Product
device="0x1004" # Device version
usb_version="0x0200" # USB 2.0
device_class="2" # Communications
cfg1="CDC" # Config 1 description
cfg2="RNDIS" # Config 2 description
power=250 # Max power
dev_mac1="42:61:64:55:53:42"
host_mac1="48:6f:73:74:50:43"
dev_mac2="42:61:64:55:53:44"
host_mac2="48:6f:73:74:50:45"
ms_vendor_code="0xcd" # Microsoft
ms_qw_sign="MSFT100" # Microsoft
ms_compat_id="RNDIS" # Matches Windows RNDIS drivers
ms_subcompat_id="5162001" # Matches Windows RNDIS 6.0 driver

cdc_mode="ecm" # Which CDC gadget to use
start_rndis=true # Whether to start the Microsoft RNDIS gadget

while getopts "ncerR" option ${@:2}; do
	case "${option}" in
		"n")
			cdc_mode=ncm
			;;
		"c")
			cdc_mode=ecm
			;;
		"e")
			cdc_mode=eem
			;;
		"r")
			start_rndis=true
			;;
		"R")
			start_rndis=false
			;;
	esac
done

case "$1" in
	start)
		# Change monitor's max refresh rate
xrandr -s 1280x1024 -r 60

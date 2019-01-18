#!/usr/bin/expect -f

set prompt "#"
set address "E9:28:D1:70:63:25"

#send_user "\nRestarting bluetooth service.\r"
#spawn sudo service bluetooth restart

spawn sudo bluetoothctl
expect -re $prompt
send "remove $address\r"
sleep 1
expect -re $prompt
send "scan on\r"
send_user "Scanning, please wait\n\r"
sleep 1
send_user "Pairing\n\r"
send "pair $address\r"
sleep 3
send_user "Connect\n\r"
send "connect $address\r"
sleep 3
send_user "Pairing\n\r"
send "pair $address\r"
sleep 3
send_user "Connect\n\r"
send "connect $address\r"
sleep 3
send_user "Pairing\n\r"
send "pair $address\r"
sleep 3
send_user "Connect\n\r"
send "connect $address\r"
sleep 3
send_user "Pairing\n\r"
send "pair $address\r"
sleep 3
send_user "Connect\n\r"
send "connect $address\r"
sleep 3
send_user "Should be paired now.\n\r"
send "quit\r"
expect eof

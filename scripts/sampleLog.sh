#!/bin/sh
# http://www.tldp.org/LDP/abs/html/io-redirection.html
echo "Hello World"
exec > script.log 2>&1
echo "Start logging out from here to a file"
bad command
echo "End logging out from here to a file"
exec > /dev/tty 2>&1 #redirects out to controlling terminal
echo "Logged in the terminal"
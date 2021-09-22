#!/bin/bash
clear
echo -n "Enter date to search for in four digits, EX. 0630 : "
read file
echo -n "Enter hour to search in two digits, Ex. 03 : "
read hour
echo -n "Enter Am or Pm : "
read ampm


cat "$file"_Dealer_schedule | awk '{print $1, $2, $5, $6}' | grep  "$hour" | grep -i "$ampm"


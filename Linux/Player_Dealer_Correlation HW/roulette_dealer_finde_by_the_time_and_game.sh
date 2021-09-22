#!/bin/bash
clear
echo -n "Enter date to search for in four digits, EX. 0630 : "
read file
echo -n "Enter hour to search in two digits, Ex. 03 : "
read hour
echo -n "Enter Am or Pm : "
read ampm
echo -n "Enter game number to check, 1 for Black Jack, 2 for Roulettw, and 3 for Texas holdem,"
read game

case "$game" in
	#case 1
	"1") cat "$file"_Dealer_schedule | awk '{print $1, $2, $3, $4}' | grep  "$hour" | grep -i "$ampm" ;;

	#case 2
	"2") cat "$file"_Dealer_schedule | awk '{print $1, $2, $5, $6}' | grep  "$hour" | grep -i "$ampm" ;;

	#case 3
	"3") cat "$file"_Dealer_schedule | awk '{print $1, $2, $7, $8}' | grep  "$hour" | grep -i "$ampm" ;;
esac

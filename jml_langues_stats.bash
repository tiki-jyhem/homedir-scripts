#!/bin/bash

#version=6.x ; 
version=$1
for langue in $version/lang/*/language.php ; 
do 
	total=$(grep '=>' $langue|wc -l)
	traduit=$(grep '=>' $langue|grep -v '//' | wc -l)
	rapport=$(($traduit*100/$total))
	echo "$rapport % - ($total) $langue"
done | sort -n

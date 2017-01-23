#!/bin/bash

for i in *
do
	echo "$i"
	new=$(echo $i | sed -e 's/\(GOPR\)\(.*\)/GP00\2/g' | sed -e 's/GP\(..\)\(....\)\./GP\2-\1./g')
	mv "$i" "$new"
done

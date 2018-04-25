#!/bin/bash

echo "== $1"
if [[ -f "$1" ]]
then
	DB_DETECTED=$(grep "^\$dbs_tiki" "$1" | cut -d"'" -f2| tail -n 1);
	USER_DETECTED=$(grep "^\$user_tiki" "$1" | cut -d"'" -f2| tail -n 1);
	PASS_DETECTED=$(grep "^\$pass_tiki" "$1" | cut -d"'" -f2| tail -n 1);
else
	echo "local.php file not found"
	exit 1
fi

DATE=$(date +"%F_%T")
IMPORT="$2"
echo $DATE
echo $IMPORT

if [ ! -f "$IMPORT" ] ; then echo "ERROR: imported database not found"; exit 2; else echo "imported database file found"; fi
#mysqldump -u "${USER_DETECTED}" --password="${PASS_DETECTED}" -Qqf --skip-extended-insert "${DB_DETECTED}" > $DUMP
mysql --force -u "${USER_DETECTED}" --password="${PASS_DETECTED}" --default-character-set=utf8 "${DB_DETECTED}" < "$IMPORT"


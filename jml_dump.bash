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

if [[ -d "$2" ]]
then
        echo "→ $2"
else
        echo "backup directory not found"
        exit 3
fi

DATE=$(date +"%F_%T")
DUMP="$2/"dump_db_${DB_DETECTED}_${DATE}.sql
DUMPLOG="$2/"dump_last_sql_${DB_DETECTED}.log
echo $DATE
echo $DUMP

read previouslog < $DUMPLOG
echo "previous: " $previouslog
touch $DUMP || exit 2
mysqldump -u "${USER_DETECTED}" --password="${PASS_DETECTED}" -Qqf --skip-extended-insert "${DB_DETECTED}" > $DUMP
echo $DUMP > $DUMPLOG

if [[ -f "$previouslog" ]]
then
        echo "Affiche la différence par rapport à $previouslog ? (y/N)"
        read affiche
        if [ "$affiche" = "y" ]
        then
                diff $previouslog $DUMP | grep -v 'INSERT INTO `tiki_pages`' | head -n 20
        fi
fi

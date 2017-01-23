#!/bin/bash

language_file_translation_script="jml_translate_buttons-v05.pl"

if [ $# -ne 2 ]
then
	echo "Usage: $0 word Word"
	echo "Mass-replaces word with Word"
	exit 1
fi

if [ `which ${language_file_translation_script}` ]; 
then 
	echo "${language_file_translation_script} is available. Good."
else 
	echo "Error: ${language_file_translation_script} is not available in your path."
	exit
fi


oldword=$1
newword=$2
oldwordescaped=`echo $oldword | sed -e 's/\//\\\\\\//g'`
newwordescaped=`echo $newword | sed -e 's/\//\\\\\\//g'`

echo -n "php files found: "
find . -name "*.php" | xargs grep -l "tra(\(['\"]\)$oldwordescaped\1" | wc -l
echo "replace '$1' with '$2' ? (return/(l)ist/(n)o/Ctrl-C)"
read toto

if [ "$toto" = "l" ]
then
	find . -name "*.php" | xargs grep "tra(\(['\"]\)$oldwordescaped\1"
	echo "replace '$1' with '$2' in php files ? (return/(n)o/Ctrl-C)"
	read toto
fi

if [ "$toto" != "n" ]
then
	find . -name "*.php" | xargs grep -l "tra(\(['\"]\)$oldwordescaped\1" | xargs perl -pi.bak -e "s/tra\((['\"])$oldwordescaped\1/tra\(\1$newwordescaped\1/g"
fi

echo -n "template files found: "
find templates -name "*.tpl" | xargs grep -l "{tr}$oldwordescaped{/tr}" | wc -l
echo "replace '$1' with '$2' ? (return/(l)ist/(n)o/Ctrl-C)"
read toto

if [ "$toto" = "l" ]
then
	find templates -name "*.tpl" | xargs grep "{tr}$oldwordescaped{/tr}"
	echo "replace '$1' with '$2' in template files ? (return/(n)o/Ctrl-C)"
	read toto
fi

echo "OK"
find templates -name "*.tpl" | xargs grep -l "{tr}$oldwordescaped{/tr}" | xargs perl -pi.bak -e "s/{tr}$oldwordescaped{\/tr}/{tr}$newwordescaped{\/tr}/g"

echo "insert '$2' translation in language files ? (return/(n)o/Ctrl-C)"
read toto

if [ "$toto" != "n" ]
then
	${language_file_translation_script} -v -i "$1" "$2"
fi

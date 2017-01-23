#!/bin/bash
echo $(pwd)

if [ $# -lt 1 ]
then
	echo "Usage: $0 taille [liste]"
	echo "Crée un répertoire 'taille' et y crée des images tronquées à 'taille'"
	echo "Par défaut, travaille sur le contenu du répertoire courant, sinon sur la liste de fichiers"
	echo "propose ensuite d'uploader"
	exit 1
fi


taille=$1
mkdir ${taille}

if [ $# -gt 1 ]
then
	shift
	liste="$@"
else
	liste=$(ls)
fi

count=0
for i in $liste
do
	if [ "$i" != "${taille}" ]
	then
		echo "== $i =="
		convert -auto-orient -geometry ${taille}x${taille} $i ${taille}/$i && ((count++))
	fi
done

echo "$count fichiers redimensionnés"
echo "Liste des fichiers distants:"
ssh avalon 'ls /tmp/photos'

echo "uploader les $count fichiers locaux ? (o/n)"
read envoi
if [ "$envoi" = "o" -o "$envoi" = "y" ]
then
	echo "OK"
	scp ${taille}/* avalon:/tmp/photos/
else
	echo "bye"
fi

echo "Fin…"
read a

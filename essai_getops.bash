#!/bin/bash

# usage() To print help
#
usage()
{
  echo "Usage: $0 [-h]"
  echo "Options: Tous les arguments sont optionnels"
  echo " -h : Cette aide"
  echo " -o 'fichier' : fichier produit"
  echo " -p CSA : Pour un CSA"
  echo " -p CSA : Pour un CSA"
  echo " -p CSA : Pour un CSA"
  echo " -p CSA : Pour un CSA"
  echo " -t 'Titre' : titre (valeur par défaut : 'Documentation sur les espaces collaboratifs Tiki')"
  echo " -s 'Nom du site' : sous-titre (valeur par défaut : 'Votre espace collaboratif Tiki')"
  exit 1
}

while getopts ":hvo:p:t:s:" optname
do
	case "$optname" in
		"h")
			usage;;
		"v")
			VERBOSE=1
			;;
		"o")
			echo "Fichier produit : $OPTARG"
			;;
		"p")
			echo "Paramètre activé : $OPTARG"
			export $OPTARG="yes"
			;;
		"t")
			echo "Titre : $OPTARG"
			export TITRE=$OPTARG
			;;
		"s")
			echo "Nom du site : $OPTARG"
			export SOUSTITRE=$OPTARG
			;;
		"?")
			echo "Argument inconnu : -$OPTARG"
			usage;;
		":")
			usage;;
		*)
			echo "Problème inconnu : -$OPTARG"
			usage;;
	esac
	shift $((OPTIND-1))
	OPTIND=1
done

exit 0

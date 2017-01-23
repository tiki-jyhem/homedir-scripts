#!/bin/bash

var="$1"
search=' '
rep='_'

# Bash
var=${var//"$search"/$rep}
mv "$1" "$var"

#!/bin/bash

export size=$1

mkdir $size 

for i in *.JPG *.png ; do echo "== $i =="; convert -geometry ${size}x${size} $i ${size}/$i; done

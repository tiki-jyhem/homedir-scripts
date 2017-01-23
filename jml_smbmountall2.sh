#!/bin/bash

echo -n "password:"
read -s PASSWORD
echo 

sudo smbmount '\\PNL304\e$' /mnt/PNL304/e_ -o uid=1000,username='KEY\libs',password=$PASSWORD && echo "E monté"
sudo smbmount '\\PNL304\c$' /mnt/PNL304/c_ -o uid=1000,username='KEY\libs',password=$PASSWORD && echo "C monté"
sudo smbmount '\\PNL304\d$' /mnt/PNL304/d_ -o uid=1000,username='KEY\libs',password=$PASSWORD && echo "D monté"

echo "done"

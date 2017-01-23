#!/bin/bash

echo -n "password:"
read -s PASSWORD
echo 

sudo smbmount '\\PNL304\e$' /mnt/PNL304/e -o uid=1000,username='KEY\libs',password=$PASSWORD && echo "E monté"
sudo smbmount '\\PNL304\c$' /mnt/PNL304/c -o uid=1000,username='KEY\libs',password=$PASSWORD && echo "C monté"
sudo smbmount '\\PNL304\d$' /mnt/PNL304/d -o uid=1000,username='KEY\libs',password=$PASSWORD && echo "D monté"

#sudo smbmount '\\comix\Export_PFinfo$' /mnt/comix/Export_PFinfo -o uid=1000,username='KEY\libs',password=$PASSWORD && echo "comix monté"

echo "done"

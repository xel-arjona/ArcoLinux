#!/bin/bash
set -e
##################################################################################################################
# Author	:	Xel Ajona
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

git init
git config --global user.name "xel-arjona"
git config --global user.email "shell_ramix@hotmail.com"
sudo git config --system core.editor nano
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=25000'
git config --global push.default simple


echo "####################################################################"
echo "###################    H A P P Y   G I T      ######################"
echo "####################################################################"

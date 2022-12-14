#!/usr/bin/env bash
#
############################################
# Script:  Push build code to apache docs  #
# Author:  JP                              #
# Date: 08/10/2022                         #
############################################


# VARS
base=/opt/pi
site=website
docs=/var/www/jp_https
lina=`arch`

# Setup architecture options
case $lina in
    x86_64)
        binp=/usr/bin
	;;
    armv7l)
        binp=/bin
	;;
    *)
        printf "Unknown machine type\n Not armv7l or x86_64\n Use uname -m to check type.\n"
	;;
esac

# Promote build file to document root
printf "Removing live files from document root.\n"
sudo $binp/rm -r $docs/*
printf "Copying new build to document root.\n"
sudo $binp/cp -r $base/$site/build/* $docs/
printf "Setting ownership of document root.\n"
sudo $binp/chown -R www-data. $docs

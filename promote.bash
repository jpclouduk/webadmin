#!/usr/bin/env bash
#
############################################
# Script:  Push build code to apache docs  #
# Author:  JP                              #
# Date: 08/10/2022                         #
############################################


# VARS
base=/opt
site=website
docs=/var/www/html

# Promote build file to document root
printf "Removing live files from document root.\n"
/usr/bin/rm -r $docs/*
printf "Copying new build to document root.\n"
/usr/bin/cp -r $base/$site/build/* $docs/

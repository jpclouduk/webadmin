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
/usr/bin/rm -r $docs/*
/usr/bin/cp -r $base/$site/build/* $docs/

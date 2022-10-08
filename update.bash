#!/usr/bin/env bash
#
##########################################
# Script:  Update existing local repo    #
# Author:  JP                            #
# Date: 08/10/2022                       #
##########################################


# VARS
base=/opt
site=website
user=jpclouduk
pass=`cat /opt/token`

# Update local repo
echo "#### Updating local repo ####"
cd $base/$website
/usr/bin/git fetch origin main
/usr/bin/git diff --summary FETCH_HEAD
/usr/bin/git merge

# Build website
echo "#### Building Website ####"
cd $base/$site
/usr/bin/npm run build

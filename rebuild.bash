#!/usr/bin/env bash
#
##########################################
# Script:  Rebuild Docusaurus            #
# Author:  JP                            #
# Date: 08/10/2022                       #
##########################################


# VARS
base=/opt
site=website
user=jpclouduk
pass=`cat /opt/token`

# Clear website
echo "#### Removing Website ####"
/usr/bin/rm -rf $base/$site

# Pull down site from github
echo "#### Retrieving Website From Github ####"
cd $base
/usr/bin/git clone https://$user:$pass@github.com/jpclouduk/website.git

# Merge code with Docusaurus
echo "#### Merging Docusaurus ####"
cd $base/$site
/usr/bin/npm install

# Build website
echo "#### Building Website ####"
cd $base/$site
/usr/bin/npm run build

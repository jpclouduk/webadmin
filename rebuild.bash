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
/usr/bin/rm $base/$site

# Pull down site from github
cd $base
git clone https://$user:$pass@github.com/jpclouduk/website.git

# Merge code with Docusaurus
cd $base/$site
npm install

#Build website
cd $base/$site
npm run build

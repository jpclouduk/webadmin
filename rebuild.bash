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
/usr/bin/rm -rf $base/$site

# Pull down site from github
cd $base
/usr/bin/git clone https://$user:$pass@github.com/jpclouduk/website.git

# Merge code with Docusaurus
cd $base/$site
/ur/bin/npm install

#Build website
cd $base/$site
/usr/bin/npm run build

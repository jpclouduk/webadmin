#!/usr/bin/env bash
#
##########################################
# Script:  Rebuild Docusaurus            #
# Author:  JP                            #
# Date: 08/10/2022                       #
##########################################


# VARS
base=/opt/pi
site=website
user=jpclouduk
pass=`cat /opt/token`
lina=`arch`

# Check command line
if [[ $1 == promote ]]
then
	echo "!!!!!  Deploy to production selected  !!!!!"
else
	echo "!!!!!  No deployment to production has been selected  !!!!!"
fi

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


# Clear website
$binp/echo "#### Removing Website ####"
$binp/rm -rf $base/$site

# Pull down site from github
echo "#### Retrieving Website From Github ####"
cd $base
/usr/bin/git clone https://$user:$pass@github.com/jpclouduk/website.git

# Merge code with Docusaurus
$binp/echo "#### Merging Docusaurus ####"
cd $base/$site
/usr/bin/npm install

# Build website
$binp/echo "#### Building Website ####"
cd $base/$site
/usr/bin/npm run build

# Check command line
if [[ $1 == promote ]]
then
	bash $base/webadmin/promote.bash
fi

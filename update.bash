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

# Usage
if [[ ( $# >= 1 ) && ( $1 != "promote") ]]
then 
	echo "Usage: $0 promote   [To push to production]"
       	echo "Usage: $0           [To NOT push to production]"
	exit 0
fi 


# Check command line
if [[ $1 == promote ]]
then
        echo "!!!!!  Deploy to production selected  !!!!!"
else
        echo "!!!!!  No deployment to production has been selected  !!!!!"
fi

# Update local repo
echo "#### Updating local repo ####"
cd $base/$site
/usr/bin/git fetch origin main
difg=`/usr/bin/git diff main origin/main --name-only`

if [[ -z $difg ]]
then
	print "The remote and local branch are the same\n Exiting"
	exit 0
else
	print "The following files will be merged to local \n $difg"
	/usr/bin/git merge
fi

exit 0

# Build website
echo "#### Building Website ####"
cd $base/$site
/usr/bin/npm run build

# Check command line
if [[ $1 == promote ]]
then
        bash $base/webadmin/promote.bash
fi
